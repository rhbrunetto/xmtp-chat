import 'package:xmtp/xmtp.dart' as xmtp;

final xmtp.CodecRegistry codecs = xmtp.CodecRegistry()
  ..registerCodec(xmtp.TextCodec());
