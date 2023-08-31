// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'my_account.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$MyAccount {
  String get address => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $MyAccountCopyWith<MyAccount> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MyAccountCopyWith<$Res> {
  factory $MyAccountCopyWith(MyAccount value, $Res Function(MyAccount) then) =
      _$MyAccountCopyWithImpl<$Res, MyAccount>;
  @useResult
  $Res call({String address});
}

/// @nodoc
class _$MyAccountCopyWithImpl<$Res, $Val extends MyAccount>
    implements $MyAccountCopyWith<$Res> {
  _$MyAccountCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? address = null,
  }) {
    return _then(_value.copyWith(
      address: null == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_MyAccountCopyWith<$Res> implements $MyAccountCopyWith<$Res> {
  factory _$$_MyAccountCopyWith(
          _$_MyAccount value, $Res Function(_$_MyAccount) then) =
      __$$_MyAccountCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String address});
}

/// @nodoc
class __$$_MyAccountCopyWithImpl<$Res>
    extends _$MyAccountCopyWithImpl<$Res, _$_MyAccount>
    implements _$$_MyAccountCopyWith<$Res> {
  __$$_MyAccountCopyWithImpl(
      _$_MyAccount _value, $Res Function(_$_MyAccount) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? address = null,
  }) {
    return _then(_$_MyAccount(
      address: null == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$_MyAccount implements _MyAccount {
  const _$_MyAccount({required this.address});

  @override
  final String address;

  @override
  String toString() {
    return 'MyAccount(address: $address)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_MyAccount &&
            (identical(other.address, address) || other.address == address));
  }

  @override
  int get hashCode => Object.hash(runtimeType, address);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_MyAccountCopyWith<_$_MyAccount> get copyWith =>
      __$$_MyAccountCopyWithImpl<_$_MyAccount>(this, _$identity);
}

abstract class _MyAccount implements MyAccount {
  const factory _MyAccount({required final String address}) = _$_MyAccount;

  @override
  String get address;
  @override
  @JsonKey(ignore: true)
  _$$_MyAccountCopyWith<_$_MyAccount> get copyWith =>
      throw _privateConstructorUsedError;
}
