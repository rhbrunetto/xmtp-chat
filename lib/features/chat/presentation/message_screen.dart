import 'package:auto_route/auto_route.dart';
import 'package:dfunc/dfunc.dart';
import 'package:eth_chat/di.dart';
import 'package:eth_chat/features/chat/data/message.dart';
import 'package:eth_chat/features/chat/presentation/widgets/chat_input_widget.dart';
import 'package:eth_chat/features/chat/services/message_service.dart';
import 'package:eth_chat/features/session/data/session.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
  late final MessageService _service;

  @override
  void initState() {
    super.initState();
    _service = sl<MessageService>(
      param1: context.read<Session>().address,
      param2: widget.topic,
    );
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text(widget.topic),
        ),
        body: ChatInputWidget(
          onNewMessage: _service.send,
          builder: (context, controller) => StreamBuilder(
            stream: _service.watchMessages(),
            builder: (context, snapshot) {
              final messages =
                  snapshot.data.ifNull(() => const IListConst<Message>([]));

              return ListView.builder(
                controller: controller,
                reverse: true,
                itemCount: messages.length,
                itemBuilder: (context, index) => ListTile(
                  title: Text(messages.elementAt(index).topic),
                ),
              );
            },
          ),
        ),
      );
}
