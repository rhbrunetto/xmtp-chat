import 'package:auto_route/auto_route.dart';
import 'package:dfunc/dfunc.dart';
import 'package:eth_chat/di.dart';
import 'package:eth_chat/features/chat/data/message.dart';
import 'package:eth_chat/features/chat/presentation/widgets/chat_input_widget.dart';
import 'package:eth_chat/features/chat/services/convo_service.dart';
import 'package:eth_chat/features/session/data/session.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

@RoutePage()
class ConvoScreen extends StatefulWidget {
  const ConvoScreen({
    super.key,
    required this.recipient,
  });

  final String recipient;

  @override
  State<ConvoScreen> createState() => _State();
}

class _State extends State<ConvoScreen> {
  late final ConvoService _service;

  @override
  void initState() {
    super.initState();
    _service = sl<ConvoService>(
      param1: context.read<Session>().address,
      param2: widget.recipient,
    );
  }

  @override
  Widget build(BuildContext context) => ChatInputWidget(
        onNewMessage: _service.send,
        child: StreamBuilder(
          stream: _service.watchMessages(),
          builder: (context, snapshot) {
            final messages =
                snapshot.data.ifNull(() => const IListConst<Message>([]));

            return ListView.builder(
              itemBuilder: (context, index) => ListTile(
                title: Text(messages.elementAt(index).text),
              ),
            );
          },
        ),
      );
}
