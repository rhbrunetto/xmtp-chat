import 'dart:typed_data';

import 'package:freezed_annotation/freezed_annotation.dart';

part 'message.freezed.dart';

@freezed
class Message with _$Message {
  const factory Message({
    required String id,
    required String topic,
    required int version,
    required DateTime sentAt,
    required String sender,
    required Uint8List encoded,
  }) = _Message;
}
