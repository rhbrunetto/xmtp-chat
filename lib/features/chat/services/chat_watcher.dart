import 'package:eth_chat/features/chat/data/chat_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class ChatWatcher {
  ChatWatcher({
    required ChatRepository repository,
  }) : _repository = repository;

  final ChatRepository _repository;

  void watch() {
    // Watch all recipients
    // For each recipient watch xmtp
    // Save messages into repository
  }

  void dispose() {
    // Stop watching
  }
}
