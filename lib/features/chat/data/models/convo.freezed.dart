// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'convo.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$Convo {
  String get topic => throw _privateConstructorUsedError;
  int get version => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  Uint8List get invite => throw _privateConstructorUsedError;
  String get me => throw _privateConstructorUsedError;
  String get peer => throw _privateConstructorUsedError;
  DateTime get lastOpenedAt => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $ConvoCopyWith<Convo> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ConvoCopyWith<$Res> {
  factory $ConvoCopyWith(Convo value, $Res Function(Convo) then) =
      _$ConvoCopyWithImpl<$Res, Convo>;
  @useResult
  $Res call(
      {String topic,
      int version,
      DateTime createdAt,
      Uint8List invite,
      String me,
      String peer,
      DateTime lastOpenedAt});
}

/// @nodoc
class _$ConvoCopyWithImpl<$Res, $Val extends Convo>
    implements $ConvoCopyWith<$Res> {
  _$ConvoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? topic = null,
    Object? version = null,
    Object? createdAt = null,
    Object? invite = null,
    Object? me = null,
    Object? peer = null,
    Object? lastOpenedAt = null,
  }) {
    return _then(_value.copyWith(
      topic: null == topic
          ? _value.topic
          : topic // ignore: cast_nullable_to_non_nullable
              as String,
      version: null == version
          ? _value.version
          : version // ignore: cast_nullable_to_non_nullable
              as int,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      invite: null == invite
          ? _value.invite
          : invite // ignore: cast_nullable_to_non_nullable
              as Uint8List,
      me: null == me
          ? _value.me
          : me // ignore: cast_nullable_to_non_nullable
              as String,
      peer: null == peer
          ? _value.peer
          : peer // ignore: cast_nullable_to_non_nullable
              as String,
      lastOpenedAt: null == lastOpenedAt
          ? _value.lastOpenedAt
          : lastOpenedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_ConvoCopyWith<$Res> implements $ConvoCopyWith<$Res> {
  factory _$$_ConvoCopyWith(_$_Convo value, $Res Function(_$_Convo) then) =
      __$$_ConvoCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String topic,
      int version,
      DateTime createdAt,
      Uint8List invite,
      String me,
      String peer,
      DateTime lastOpenedAt});
}

/// @nodoc
class __$$_ConvoCopyWithImpl<$Res> extends _$ConvoCopyWithImpl<$Res, _$_Convo>
    implements _$$_ConvoCopyWith<$Res> {
  __$$_ConvoCopyWithImpl(_$_Convo _value, $Res Function(_$_Convo) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? topic = null,
    Object? version = null,
    Object? createdAt = null,
    Object? invite = null,
    Object? me = null,
    Object? peer = null,
    Object? lastOpenedAt = null,
  }) {
    return _then(_$_Convo(
      topic: null == topic
          ? _value.topic
          : topic // ignore: cast_nullable_to_non_nullable
              as String,
      version: null == version
          ? _value.version
          : version // ignore: cast_nullable_to_non_nullable
              as int,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      invite: null == invite
          ? _value.invite
          : invite // ignore: cast_nullable_to_non_nullable
              as Uint8List,
      me: null == me
          ? _value.me
          : me // ignore: cast_nullable_to_non_nullable
              as String,
      peer: null == peer
          ? _value.peer
          : peer // ignore: cast_nullable_to_non_nullable
              as String,
      lastOpenedAt: null == lastOpenedAt
          ? _value.lastOpenedAt
          : lastOpenedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc

class _$_Convo implements _Convo {
  const _$_Convo(
      {required this.topic,
      required this.version,
      required this.createdAt,
      required this.invite,
      required this.me,
      required this.peer,
      required this.lastOpenedAt});

  @override
  final String topic;
  @override
  final int version;
  @override
  final DateTime createdAt;
  @override
  final Uint8List invite;
  @override
  final String me;
  @override
  final String peer;
  @override
  final DateTime lastOpenedAt;

  @override
  String toString() {
    return 'Convo(topic: $topic, version: $version, createdAt: $createdAt, invite: $invite, me: $me, peer: $peer, lastOpenedAt: $lastOpenedAt)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Convo &&
            (identical(other.topic, topic) || other.topic == topic) &&
            (identical(other.version, version) || other.version == version) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            const DeepCollectionEquality().equals(other.invite, invite) &&
            (identical(other.me, me) || other.me == me) &&
            (identical(other.peer, peer) || other.peer == peer) &&
            (identical(other.lastOpenedAt, lastOpenedAt) ||
                other.lastOpenedAt == lastOpenedAt));
  }

  @override
  int get hashCode => Object.hash(runtimeType, topic, version, createdAt,
      const DeepCollectionEquality().hash(invite), me, peer, lastOpenedAt);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_ConvoCopyWith<_$_Convo> get copyWith =>
      __$$_ConvoCopyWithImpl<_$_Convo>(this, _$identity);
}

abstract class _Convo implements Convo {
  const factory _Convo(
      {required final String topic,
      required final int version,
      required final DateTime createdAt,
      required final Uint8List invite,
      required final String me,
      required final String peer,
      required final DateTime lastOpenedAt}) = _$_Convo;

  @override
  String get topic;
  @override
  int get version;
  @override
  DateTime get createdAt;
  @override
  Uint8List get invite;
  @override
  String get me;
  @override
  String get peer;
  @override
  DateTime get lastOpenedAt;
  @override
  @JsonKey(ignore: true)
  _$$_ConvoCopyWith<_$_Convo> get copyWith =>
      throw _privateConstructorUsedError;
}
