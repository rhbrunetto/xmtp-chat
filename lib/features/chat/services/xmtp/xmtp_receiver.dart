// Original code available here: https://github.com/xmtp/xmtp-flutter/blob/main/example/lib/session/manager.dart
// Important changes were made due consistency / best practices.

import 'dart:async';
import 'dart:math' as math;

import 'package:dfunc/dfunc.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:quiver/iterables.dart';
import 'package:retry/retry.dart';
import 'package:xmtp/xmtp.dart' as xmtp;

import '../../data/convo_repository.dart';
import '../../data/message_repository.dart';
import 'xmtp_adapter.dart';

@injectable
class XmtpReceiver {
  XmtpReceiver({
    @factoryParam required xmtp.Client client,
    required ConvoRepository convoRepository,
    required MessageRepository messageRepository,
  })  : _client = client,
        _convoRepository = convoRepository,
        _messageRepository = messageRepository;

  final xmtp.Client _client;
  final ConvoRepository _convoRepository;
  final MessageRepository _messageRepository;

  StreamSubscription<xmtp.Conversation>? _conversationStream;
  StreamSubscription<xmtp.DecodedMessage>? _messageStream;

  final _messageStreamTopics = <String>{};
  final _recovery = _Recovery();

  Future<void> start() async {
    _restartConversationStream();
    _restartMessageStream();

    final lastConversation = await _convoRepository.readLastConversation();
    await refreshConversations(since: lastConversation?.createdAt);

    final conversations = await _convoRepository
        .readConversations()
        .letAsync((it) => it.map((c) => c.toXmtp()));
    final lastReceivedAt = await _messageRepository.lastReceivedSentAt();
    await _refreshMessages(conversations, since: lastReceivedAt);
  }

  Future<void> stop() async {
    _stopConversationStream();
    _stopMessageStream();
    _recovery.reset();
  }

  Future<int> refreshMessages({
    required List<String> topics,
    required DateTime? since,
  }) async {
    final topicSet = Set.from(topics);
    final convos = await _convoRepository
        .readConversations()
        .letAsync((it) => it.where((c) => topicSet.contains(c.topic)))
        .letAsync((it) => it.map((c) => c.toXmtp()));

    return _refreshMessages(convos, since: since);
  }

  Future<int> refreshConversations({DateTime? since}) async {
    since ??= await _convoRepository
        .readLastConversation()
        .letAsync((it) => it?.createdAt);
    final convos = await _client.listConversations(start: since);
    await _convoRepository.saveConversations(convos.map((it) => it.toDb()));
    _fillEmptyHistories().ignore();

    return convos.length;
  }

  Future<void> _fillEmptyHistories() async {
    final clock = Stopwatch()..start();
    final convos = await _convoRepository
        .readEmptyConversations()
        .letAsync((it) => it.map((it) => it.toXmtp()));

    debugPrint('backfill started: (count ${convos.length})');

    final batches = partition(convos, 3);
    for (final batch in batches) {
      await Future.wait(batch.map((conversation) async {
        try {
          await _refreshMessages([conversation]);
        } catch (e) {
          debugPrint('error refreshing conversations: $e');
        }
      }));
    }

    debugPrint(
        'backfill finished: (count ${convos.length}) ${clock.elapsedMilliseconds} ms');
  }

  Future<int> _refreshMessages(
    Iterable<xmtp.Conversation> conversations, {
    DateTime? since,
  }) async {
    final messages = await _client.listBatchMessages(
      conversations,
      start: since,
    );
    await _messageRepository.saveMessages(messages.map((it) => it.toDb()));
    return messages.length;
  }

  Future<void> _restartConversationStream() async {
    _stopConversationStream();
    _conversationStream = _client.streamConversations().listen(
      _onConvo,
      onError: (_) {
        _stopConversationStream();
        _recovery.attempt("conversations", _restartConversationStream);
      },
    );
  }

  Future<void> _onConvo(xmtp.Conversation convo) async {
    await _convoRepository.saveConversations([convo.toDb()]);
    await _refreshMessages([convo]);
    _restartMessageStream();
  }

  void _restartMessageStream() async {
    final convos = await _convoRepository
        .readConversations()
        .letAsync((it) => it.map((c) => c.toXmtp()));
    final topics = Set.from(convos.map((c) => c.topic));

    if (setEquals(topics, _messageStreamTopics)) return;

    _stopMessageStream();
    if (convos.isEmpty) return;

    _messageStream = _client.streamBatchMessages(convos).listen(
      _onMessage,
      onError: (_) {
        _stopMessageStream();
        _recovery.attempt("messages", () => _restartMessageStream());
      },
    );
  }

  Future<void> _onMessage(xmtp.DecodedMessage decodedMessage) async {
    final topic = decodedMessage.topic;
    final isFirst = await _messageRepository.readLastMessage(topic) == null;
    if (isFirst) {
      final convo = await _convoRepository.read(topic);
      if (convo == null) return;
      _refreshMessages([convo.toXmtp()]);
    }
    await _messageRepository.saveMessages([decodedMessage.toDb()]);
  }

  void _stopMessageStream() {
    _recovery.cancel("messages");
    _messageStreamTopics.clear();
    _messageStream?.cancel();
    _messageStream = null;
  }

  void _stopConversationStream() {
    _recovery.cancel("conversations");
    _conversationStream?.cancel();
    _conversationStream = null;
  }
}

class _Recovery {
  final Map<String, Timer> _attempts = {};
  final RetryOptions _config = const RetryOptions();

  final List<DateTime> _recentStack = [];

  void attempt(String name, void Function() doRecovery) =>
      _attempts[name] ??= Timer(_config.delay(_incrementRecentCount()), () {
        _attempts.remove(name);
        doRecovery();
      });

  void cancel(String name) => _attempts.remove(name)?.cancel();

  void reset() {
    for (var timer in _attempts.values) {
      timer.cancel();
    }
    _attempts.clear();
    _recentStack.clear();
  }

  int _incrementRecentCount() {
    var now = DateTime.now();
    _recentStack
      ..insert(0, now)
      ..removeWhere((t) => t.isBefore(now.subtract(_config.maxDelay)))
      ..length = math.min(_recentStack.length, _config.maxAttempts);
    return _recentStack.length;
  }
}
