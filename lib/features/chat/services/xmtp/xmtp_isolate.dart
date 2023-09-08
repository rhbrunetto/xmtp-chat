// Original code available here: https://github.com/xmtp/xmtp-flutter/blob/main/example/lib/session/isolate.dart
// Few changes were made due consistency / best practices.

import 'dart:async';
import 'dart:isolate';
import 'dart:ui';

import 'package:eth_chat/di.dart';
import 'package:eth_chat/features/chat/services/xmtp/xmtp_receiver.dart';
import 'package:eth_chat/features/chat/services/xmtp/xmtp_sender.dart';
import 'package:flutter/foundation.dart';
import 'package:xmtp/xmtp.dart' as xmtp;

enum XmtpIsolateCommand {
  kill,
  refreshConversations,
  refreshMessages,
  canMessage,
  newConversation,
  sendMessage,
}

// TODO(rhbrunetto): refactor to allow DI (no need to use get/find methods)
class XmtpIsolate {
  XmtpIsolate.fromPort(this.sendToWorker);

  final SendPort sendToWorker;

  static const commandTimeout = Duration(seconds: 30);

  static Future<XmtpIsolate> spawn(xmtp.PrivateKeyBundle keys) async {
    final existing = find();
    if (existing != null) {
      debugPrint('using pre-existing xmtp isolate instead of spawning another');
      return existing;
    }
    debugPrint('starting xmtp isolate for ${keys.wallet}');
    _foregroundReceiver.listenForResponses();
    await Isolate.spawn(
        _mainXmtpIsolate, [_foregroundReceiver.port.sendPort, keys]);
    final sendToWorker = await _foregroundReceiver.listeningForPort.future
        .timeout(commandTimeout);
    return XmtpIsolate.fromPort(sendToWorker);
  }

  static XmtpIsolate? find() {
    final alreadyStarted = IsolateNameServer.lookupPortByName(_workerPortName);
    if (alreadyStarted == null) {
      debugPrint('unable to find pre-existing xmtp isolate');
      return null;
    }
    debugPrint('found pre-existing xmtp isolate');
    return XmtpIsolate.fromPort(alreadyStarted);
  }

  Future<bool> kill() async {
    debugPrint('killing xmtp isolate');
    final existing = find();
    if (existing == null) {
      debugPrint('unable to find a pre-existing xmtp isolate to kill');
      return false;
    }
    IsolateNameServer.removePortNameMapping(_workerPortName);
    await existing.command(XmtpIsolateCommand.kill);
    return true;
  }

  Future<T> command<T>(XmtpIsolateCommand method,
      {List args = const []}) async {
    final id = "${_commandCount++}-$method";
    debugPrint('sending command: $id');
    final result = _foregroundReceiver.waitForIdentifiedResult<T>(id);
    sendToWorker.send([id, method, args]);
    return result.timeout(commandTimeout);
  }
}

//TODO(rhbrunetto): generate code for interface / dispatcher
Map<
    XmtpIsolateCommand,
    Future<Object?> Function(
      XmtpReceiver receiver,
      XmtpSender sender,
      List args,
    )> _commands = {
  XmtpIsolateCommand.kill: (receiver, _, args) => receiver.stop(),
  XmtpIsolateCommand.refreshConversations: (receiver, _, args) =>
      receiver.refreshConversations(
        since: args[0] as DateTime?,
      ),
  XmtpIsolateCommand.refreshMessages: (receiver, _, args) =>
      receiver.refreshMessages(
        topics: args[0] as List<String>,
        since: args[1] as DateTime?,
      ),
  XmtpIsolateCommand.canMessage: (_, sender, args) =>
      sender.canMessage(args[0] as String),
  XmtpIsolateCommand.newConversation: (_, sender, args) => sender
      .newConversation(
        args[0] as String,
        conversationId: args[1] as String,
        metadata: args[2] as Map<String, String>,
      )
      .then((convo) => convo.topic),
  XmtpIsolateCommand.sendMessage: (_, sender, args) => sender
      .sendMessage(
        args[0] as String,
        args[1] as xmtp.EncodedContent,
      )
      .then((sent) => sent.id),
};

void _mainXmtpIsolate(List args) async {
  await configureDependencies();

  final responsePort = args[0] as SendPort;
  final keys = args[1] as xmtp.PrivateKeyBundle;

  debugPrint('starting xmtp worker for ${keys.wallet}');

  //TODO(rhbrunetto): improve DI on isolate
  final client = await xmtp.Client.createFromKeys(sl<xmtp.Api>(), keys);
  final receiver = sl<XmtpReceiver>(param1: client);
  final sender = sl<XmtpSender>(param1: client);

  final ReceivePort workerPort = ReceivePort('xmtp worker');

  //TODO(rhbrunetto): improve listening, this can cause mem leak
  workerPort.listen((command) async {
    try {
      if (command is List && command.length == 3) {
        final id = command[0];
        final method = command[1];
        final args = command[2] ?? [];
        debugPrint('worker received command: $method');
        try {
          final res = await _commands[method]?.call(receiver, sender, args);
          responsePort.send(["complete", id, true, res]);
        } catch (err) {
          debugPrint('worker failed to execute command: $method: $err');
          responsePort.send(["complete", id, false, null]);
        }
      } else {
        debugPrint('worker discarding malformed command: $command');
      }
    } catch (err) {
      debugPrint('error handling xmtp isolate request: $err');
    }
  });
  responsePort.send(["port", workerPort.sendPort]);

  receiver.start();
}

int _commandCount = 0;
const String _workerPortName = 'xmtp_worker';
final _foregroundReceiver = _ForegroundReceiver();
const _commandTimeout = Duration(seconds: 30);

class _ForegroundReceiver {
  final port = ReceivePort('xmtp isolate connect');
  final Completer<SendPort> listeningForPort = Completer();
  final Map<String, Completer<Object?>> pending = {};
  bool isListening = false;

  Future<T> waitForIdentifiedResult<T>(String id) {
    Completer<T> completer = (pending[id] = Completer<T>());
    return completer.future.timeout(_commandTimeout)
      ..whenComplete(() => pending.remove(id));
  }

  void listenForResponses() {
    if (isListening) {
      debugPrint('xmtp foreground already listening for command responses');
      return;
    }
    debugPrint('xmtp foreground started listening for command responses');
    isListening = true;
    port.listen((res) {
      try {
        if (res is List && res.isNotEmpty) {
          debugPrint('UI received response: $res');
          final type = res[0];
          if (type == "port") {
            _handlePort(res[1] as SendPort);
          } else if (type == "complete") {
            _handleCompletion(
                res[1] as String, res[2] as bool, res[3] as Object?);
          } else {
            debugPrint('unexpected response: $res');
          }
        } else {
          debugPrint('malformed response: $res');
        }
      } catch (err) {
        debugPrint('error handling xmtp isolate response: $err');
      }
    });
  }

  void _handlePort(SendPort workerPort) {
    IsolateNameServer.registerPortWithName(workerPort, _workerPortName);
    debugPrint('registered xmtp isolate at $_workerPortName');
    listeningForPort.complete(workerPort);
  }

  void _handleCompletion(String id, bool success, Object? result) {
    if (!pending.containsKey(id)) {
      debugPrint('unexpected pending command completion: $id');
    }
    if (success) {
      pending[id]?.complete(result);
    } else {
      pending[id]?.completeError('command failed');
    }
    pending.remove(id);
  }
}
