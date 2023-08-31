import 'package:freezed_annotation/freezed_annotation.dart';

part 'message.freezed.dart';

@freezed
class Message with _$Message {
  const factory Message({
    required String id,
    required String recipient,
    required String sender,
    required DateTime createdAt,
    required String text,
  }) = _Message;
}

