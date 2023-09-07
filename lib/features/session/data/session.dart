import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:walletconnect_flutter_v2/walletconnect_flutter_v2.dart';
import 'package:xmtp/xmtp.dart' as xmtp;

part 'session.freezed.dart';

@freezed
class Session with _$Session {
  const factory Session({
    required Web3App app,
    required SessionData sessionData,
    // required xmtp.Client xmtpClient,
  }) = _Session;
}

extension SessionExt on Session {
  String get address => sessionData.peer.publicKey;
}
