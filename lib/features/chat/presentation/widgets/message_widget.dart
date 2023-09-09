import 'package:chat_bubbles/chat_bubbles.dart';
import 'package:dfunc/dfunc.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
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
          } // TODO(rhbrunetto): add support to other content types
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
  Widget build(BuildContext context) => Column(
        children: [
          BubbleSpecialOne(
            text: text,
            isSender: isMine,
            textStyle: const TextStyle(fontSize: 16),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18),
            child: Align(
              alignment: isMine ? Alignment.topRight : Alignment.topLeft,
              child: Text(
                _formatter.format(sentAt),
                style: const TextStyle(fontSize: 8),
              ),
            ),
          ),
          const SizedBox(height: 8),
        ],
      );
}

final _formatter = DateFormat.yMd().add_jm();
