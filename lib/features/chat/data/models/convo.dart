import 'dart:typed_data';

import 'package:freezed_annotation/freezed_annotation.dart';

part 'convo.freezed.dart';

@freezed
class Convo with _$Convo {
  const factory Convo({
    required String topic,
    required int version,
    required DateTime createdAt,
    required Uint8List invite,
    required String me,
    required String peer,
    required DateTime lastOpenedAt,
  }) = _Convo;
}
