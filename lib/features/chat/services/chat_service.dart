import 'dart:async';

import 'package:eth_chat/features/chat/data/convo_repository.dart';
import 'package:eth_chat/features/chat/data/message_repository.dart';
import 'package:eth_chat/features/chat/services/xmtp/xmtp_isolate.dart';
import 'package:eth_chat/utils/namespace.dart';
import 'package:injectable/injectable.dart';
import 'package:xmtp/xmtp.dart' as xmtp;

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

  Future<void> newChat(String recipient) async {
    // TODO(rhbrunetto): submit to xmtp, save into chatrepository
  }

  Future<void> send(String topic, String message) async {
    _isolate.command(
      XmtpIsolateCommand.sendMessage,
      args: [
        topic,
        (await codecs.encode(xmtp.DecodedContent(
          xmtp.contentTypeText,
          message,
        )))
      ],
    );
  }
  // Stream<IList<Chat>> watchMessages() =>
  //     _repository.watchContacts(_sender).map((list) => list
  //         .map((it) => Chat(recipient: it.recipient, lastMessage: it.text))
  //         .toIListkk());
}
