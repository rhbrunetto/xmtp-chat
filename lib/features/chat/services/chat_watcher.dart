import 'package:eth_chat/features/chat/data/chat_repository.dart';

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
