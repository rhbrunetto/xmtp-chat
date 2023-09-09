import 'package:injectable/injectable.dart';
import 'package:xmtp/xmtp.dart' as xmtp;

import '../../data/convo_repository.dart';
import '../../data/message_repository.dart';
import 'xmtp_adapter.dart';

@injectable
class XmtpSender {
  XmtpSender({
    @factoryParam required xmtp.Client client,
    required ConvoRepository convoRepository,
    required MessageRepository messageRepository,
  })  : _client = client,
        _convoRepository = convoRepository,
        _messageRepository = messageRepository;

  final xmtp.Client _client;
  final ConvoRepository _convoRepository;
  final MessageRepository _messageRepository;

  Future<bool> canMessage(String address) => _client.canMessage(address);

  Future<xmtp.Conversation> newConversation(
    String address, {
    String conversationId = '',
    Map<String, String> metadata = const <String, String>{},
  }) =>
      _client.newConversation(
        address,
        conversationId: conversationId,
        metadata: metadata,
      );

  Future<xmtp.DecodedMessage> sendMessage(
    String topic,
    xmtp.EncodedContent encoded,
  ) async {
    final convo = await _convoRepository.read(topic);
    final msg = await _client.sendMessageEncoded(convo!.toXmtp(), encoded);
    await _messageRepository.saveMessages([msg!.toDb()]);
    return msg;
  }
}
