import 'dart:async';

import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:injectable/injectable.dart';
import 'package:xmtp/xmtp.dart' as xmtp;

import '../../../utils/namespace.dart';
import '../data/convo_repository.dart';
import '../data/message_repository.dart';
import '../data/models/convo.dart';
import '../data/models/message.dart';
import 'xmtp/xmtp_isolate.dart';

@injectable
class ChatService {
  const ChatService({
    @factoryParam required XmtpIsolate isolate,
    required MessageRepository messageRepository,
    required ConvoRepository convoRepository,
  })  : _messageRepository = messageRepository,
        _convoRepository = convoRepository,
        _isolate = isolate;

  final XmtpIsolate _isolate;
  final MessageRepository _messageRepository;
  final ConvoRepository _convoRepository;

  Stream<IList<Convo>> watchConversations() =>
      _convoRepository.watchConversations();

  Stream<IList<Message>> watchMessages(String topic) =>
      _messageRepository.watchMessages(topic: topic);

  Future<String> refreshConversations() => _isolate.command(
        XmtpIsolateCommand.refreshConversations,
        args: [null],
      );

  Future<String> refreshMessages(String topic) => _isolate.command(
        XmtpIsolateCommand.refreshMessages,
        args: [
          [topic],
          null,
        ],
      );

  Future<String> newConversation(String address) => _isolate.command(
        XmtpIsolateCommand.newConversation,
        args: [address, '', const <String, String>{}],
      );

  Future<void> sendMessage({
    required String topic,
    required String message,
  }) async =>
      _isolate.command(
        XmtpIsolateCommand.sendMessage,
        args: [
          topic,
          (
            await codecs.encode(
              xmtp.DecodedContent(xmtp.contentTypeText, message),
            ),
          ),
        ],
      );
}
