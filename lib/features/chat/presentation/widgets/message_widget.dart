import 'package:dfunc/dfunc.dart';
import 'package:flutter/material.dart';
import 'package:xmtp/xmtp.dart' as xmtp;

import '../../../../utils/namespace.dart';
import '../../data/models/message.dart';

class MessageWidget extends StatelessWidget {
  const MessageWidget({
    super.key,
    required this.message,
    required this.isMine,
  });

  final Message message;
  final bool isMine;

  Future<Object> _decode() => message.encoded
      .let(xmtp.EncodedContent.fromBuffer)
      .let(codecs.decode)
      .letAsync((it) => it.content);

  @override
  Widget build(BuildContext context) => FutureBuilder(
        future: _decode(),
        builder: (context, snapshot) {
          final content = snapshot.data;

          if (content is String) {
            return _TextMessageWidget(
              text: content,
              sentAt: message.sentAt,
              isMine: isMine,
            );
          }

          // TODO(rhbrunetto): add support to other content types
          return const SizedBox.shrink();
        },
      );
}

class _TextMessageWidget extends StatelessWidget {
  const _TextMessageWidget({
    required this.text,
    required this.sentAt,
    required this.isMine,
  });

  final String text;
  final DateTime sentAt;
  final bool isMine;

  @override
  Widget build(BuildContext context) => ListTile(
        title: Text(text),
        subtitle: Text(sentAt.toIso8601String()),
        tileColor: isMine ? Colors.white : Colors.lightBlue,
      );
}
