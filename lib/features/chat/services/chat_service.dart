import 'dart:async';

import 'package:eth_chat/features/chat/data/chat.dart';
import 'package:eth_chat/features/chat/data/chat_repository.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:injectable/injectable.dart';

@injectable
class ChatService {
  const ChatService({
    @factoryParam required String sender,
    required ChatRepository repository,
  })  : _sender = sender,
        _repository = repository;

  final String _sender;
  final ChatRepository _repository;

  Future<void> newChat(String recipient) async {
    // TODO(rhbrunetto): submit to xmtp, save into chatrepository
  }

  Stream<IList<Chat>> watchMessages() =>
      _repository.watchContacts(_sender).map((list) => list
          .map((it) => Chat(recipient: it.recipient, lastMessage: it.text))
          .toIList());
}
