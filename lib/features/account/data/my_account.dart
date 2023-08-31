import 'package:freezed_annotation/freezed_annotation.dart';

part 'my_account.freezed.dart';

@freezed
class MyAccount with _$MyAccount {
  const factory MyAccount({
    required String address,
  }) = _MyAccount;
}
