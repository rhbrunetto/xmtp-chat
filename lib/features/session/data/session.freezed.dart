// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'session.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$Session {
  Web3App get app => throw _privateConstructorUsedError;
  SessionData get sessionData => throw _privateConstructorUsedError;
  WalletConnectModalService get modalService =>
      throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $SessionCopyWith<Session> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SessionCopyWith<$Res> {
  factory $SessionCopyWith(Session value, $Res Function(Session) then) =
      _$SessionCopyWithImpl<$Res, Session>;
  @useResult
  $Res call(
      {Web3App app,
      SessionData sessionData,
      WalletConnectModalService modalService});

  $SessionDataCopyWith<$Res> get sessionData;
}

/// @nodoc
class _$SessionCopyWithImpl<$Res, $Val extends Session>
    implements $SessionCopyWith<$Res> {
  _$SessionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? app = null,
    Object? sessionData = null,
    Object? modalService = null,
  }) {
    return _then(_value.copyWith(
      app: null == app
          ? _value.app
          : app // ignore: cast_nullable_to_non_nullable
              as Web3App,
      sessionData: null == sessionData
          ? _value.sessionData
          : sessionData // ignore: cast_nullable_to_non_nullable
              as SessionData,
      modalService: null == modalService
          ? _value.modalService
          : modalService // ignore: cast_nullable_to_non_nullable
              as WalletConnectModalService,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $SessionDataCopyWith<$Res> get sessionData {
    return $SessionDataCopyWith<$Res>(_value.sessionData, (value) {
      return _then(_value.copyWith(sessionData: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$_SessionCopyWith<$Res> implements $SessionCopyWith<$Res> {
  factory _$$_SessionCopyWith(
          _$_Session value, $Res Function(_$_Session) then) =
      __$$_SessionCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {Web3App app,
      SessionData sessionData,
      WalletConnectModalService modalService});

  @override
  $SessionDataCopyWith<$Res> get sessionData;
}

/// @nodoc
class __$$_SessionCopyWithImpl<$Res>
    extends _$SessionCopyWithImpl<$Res, _$_Session>
    implements _$$_SessionCopyWith<$Res> {
  __$$_SessionCopyWithImpl(_$_Session _value, $Res Function(_$_Session) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? app = null,
    Object? sessionData = null,
    Object? modalService = null,
  }) {
    return _then(_$_Session(
      app: null == app
          ? _value.app
          : app // ignore: cast_nullable_to_non_nullable
              as Web3App,
      sessionData: null == sessionData
          ? _value.sessionData
          : sessionData // ignore: cast_nullable_to_non_nullable
              as SessionData,
      modalService: null == modalService
          ? _value.modalService
          : modalService // ignore: cast_nullable_to_non_nullable
              as WalletConnectModalService,
    ));
  }
}

/// @nodoc

class _$_Session implements _Session {
  const _$_Session(
      {required this.app,
      required this.sessionData,
      required this.modalService});

  @override
  final Web3App app;
  @override
  final SessionData sessionData;
  @override
  final WalletConnectModalService modalService;

  @override
  String toString() {
    return 'Session(app: $app, sessionData: $sessionData, modalService: $modalService)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Session &&
            (identical(other.app, app) || other.app == app) &&
            (identical(other.sessionData, sessionData) ||
                other.sessionData == sessionData) &&
            (identical(other.modalService, modalService) ||
                other.modalService == modalService));
  }

  @override
  int get hashCode => Object.hash(runtimeType, app, sessionData, modalService);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_SessionCopyWith<_$_Session> get copyWith =>
      __$$_SessionCopyWithImpl<_$_Session>(this, _$identity);
}

abstract class _Session implements Session {
  const factory _Session(
      {required final Web3App app,
      required final SessionData sessionData,
      required final WalletConnectModalService modalService}) = _$_Session;

  @override
  Web3App get app;
  @override
  SessionData get sessionData;
  @override
  WalletConnectModalService get modalService;
  @override
  @JsonKey(ignore: true)
  _$$_SessionCopyWith<_$_Session> get copyWith =>
      throw _privateConstructorUsedError;
}
