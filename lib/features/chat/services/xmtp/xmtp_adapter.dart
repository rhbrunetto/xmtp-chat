import 'package:eth_chat/features/chat/data/models/convo.dart';
import 'package:eth_chat/features/chat/data/models/message.dart';
import 'package:web3dart/web3dart.dart';
import 'package:xmtp/xmtp.dart' as xmtp;

extension XmtpToDbConversation on xmtp.Conversation {
  Convo toDb() => Convo(
        topic: topic,
        version: version.index,
        createdAt: createdAt,
        invite: invite.writeToBuffer(),
        me: me.hexEip55,
        peer: peer.hexEip55,
        lastOpenedAt: DateTime.now(),
      );
}

extension DbToXmtpConversation on Convo {
  xmtp.Conversation toXmtp() {
    if (xmtp.Message_Version.values[version] == xmtp.Message_Version.v1) {
      return xmtp.Conversation.v1(
        createdAt,
        me: EthereumAddress.fromHex(me),
        peer: EthereumAddress.fromHex(peer),
      );
    }
    return xmtp.Conversation.v2(
      xmtp.InvitationV1.fromBuffer(invite),
      createdAt,
      me: EthereumAddress.fromHex(me),
      peer: EthereumAddress.fromHex(peer),
    );
  }
}

extension XmtpToDbMessage on xmtp.DecodedMessage {
  Message toDb() => Message(
        id: id,
        topic: topic,
        version: version.index,
        sentAt: sentAt,
        encoded: encoded.writeToBuffer(),
        sender: sender.hexEip55,
      );
}

extension DbToXmtpMessage on Message {
  Future<xmtp.DecodedMessage> toXmtp(
    xmtp.Codec<xmtp.DecodedContent> decoder,
  ) async {
    var encodedParsed = xmtp.EncodedContent.fromBuffer(encoded);
    var decoded = await decoder.decode(encodedParsed);
    return xmtp.DecodedMessage(
      topic: topic,
      id: id,
      xmtp.Message_Version.values[version],
      sentAt,
      EthereumAddress.fromHex(sender),
      encodedParsed,
      decoded.contentType,
      decoded.content,
    );
  }
}
