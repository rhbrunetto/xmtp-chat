import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:walletconnect_flutter_v2/walletconnect_flutter_v2.dart';

part 'session.freezed.dart';

@freezed
class Session with _$Session {
  const factory Session({
    required Web3App app,
    required SessionData sessionData,
  }) = _Session;
}

extension SessionExt on Session {
  String get address => NamespaceUtils.getAccount(
        sessionData.namespaces.values.first.accounts.first,
      );
}
