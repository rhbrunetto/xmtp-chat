import 'package:auto_route/auto_route.dart';
import 'package:dfunc/dfunc.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../session/data/session.dart';
import '../data/models/message.dart';
import '../services/chat_service.dart';
import 'widgets/chat_input_widget.dart';
import 'widgets/message_widget.dart';

@RoutePage()
class MessageScreen extends StatefulWidget {
  const MessageScreen({
    super.key,
    required this.topic,
  });

  final String topic;

  @override
  State<MessageScreen> createState() => _State();
}

class _State extends State<MessageScreen> {
  late final ChatService _service;
  late final Session _session;

  @override
  void initState() {
    super.initState();
    _service = context.read<ChatService>();
    _session = context.read<Session>();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text(widget.topic),
        ),
        body: RefreshIndicator(
          onRefresh: () => _service.refreshMessages(widget.topic),
          child: SafeArea(
            child: Material(
              child: ChatInputWidget(
                onNewMessage: (message) => _service.sendMessage(
                  topic: widget.topic,
                  message: message,
                ),
                child: StreamBuilder(
                  stream: _service.watchMessages(widget.topic),
                  builder: (context, snapshot) {
                    final messages = snapshot.data
                        .ifNull(() => const IListConst<Message>([]));

                    return ListView.builder(
                      reverse: true,
                      itemCount: messages.length,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      itemBuilder: (context, index) {
                        final message = messages.elementAt(index);

                        return MessageWidget(
                          message: message,
                          isMine: message.sender == _session.address,
                        );
                      },
                    );
                  },
                ),
              ),
            ),
          ),
        ),
      );
}
