import 'dart:async';

import 'package:eth_chat/features/chat/data/chat_repository.dart';
import 'package:eth_chat/features/chat/data/message.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:injectable/injectable.dart';

@injectable
class ConvoService {
  const ConvoService({
    @factoryParam required String sender,
    @factoryParam required String recipient,
    required ChatRepository repository,
  })  : _recipient = recipient,
        _sender = sender,
        _repository = repository;

  final String _sender;
  final String _recipient;
  final ChatRepository _repository;

  Future<void> send(String message) async {
    // TODO(rhbrunetto): submit to xmtp, save into chatrepository
  }

  Stream<IList<Message>> watchMessages() => _repository.watchMessages(
        sender: _sender,
        recipient: _recipient,
      );
}
