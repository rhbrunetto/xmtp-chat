import 'package:auto_route/auto_route.dart';
import 'package:dfunc/dfunc.dart';
import 'package:eth_chat/features/chat/data/models/convo.dart';
import 'package:eth_chat/features/chat/presentation/widgets/new_chat_dialog.dart';
import 'package:eth_chat/features/chat/services/chat_service.dart';
import 'package:eth_chat/features/session/services/session_cubit.dart';
import 'package:eth_chat/routes.gr.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class ChatListScreen extends StatefulWidget {
  const ChatListScreen({super.key});

  @override
  State<ChatListScreen> createState() => _State();
}

class _State extends State<ChatListScreen> {
  late final ChatService _service;

  @override
  void initState() {
    super.initState();
    _service = context.read<ChatService>();
  }

  void _openChat(String topic) =>
      context.router.push(MessageRoute(topic: topic));

  Future<void> _onNewChat() async {
    final recipient = await showDialog(
      context: context,
      builder: (context) => const NewChatDialog(),
    );
    if (recipient == null) return;
    final topic = await _service.newConversation(recipient);
    _openChat(topic);
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text('Chats'),
          actions: const [_PopMenu()],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: _onNewChat,
          child: const Icon(Icons.chat),
        ),
        body: RefreshIndicator(
          onRefresh: _service.refreshConversations,
          child: StreamBuilder(
            stream: _service.watchConversations(),
            builder: (context, snapshot) {
              final conversations =
                  snapshot.data.ifNull(() => const IListConst<Convo>([]));

              if (snapshot.hasError) {
                return const Center(
                  child: Text('Failed to load chats'),
                );
              }

              return ListView.builder(
                itemCount: conversations.length,
                itemBuilder: (context, index) {
                  final conversation = conversations.elementAt(index);

                  return ListTile(
                    title: Text(conversation.peer),
                    onTap: () => _openChat(conversation.topic),
                  );
                },
              );
            },
          ),
        ),
      );
}

class _PopMenu extends StatelessWidget {
  const _PopMenu();

  @override
  Widget build(BuildContext context) => PopupMenuButton(
        itemBuilder: (context) => [
          PopupMenuItem(
            child: const Text('Disconnect'),
            onTap: () => context.read<SessionCubit>().disconnect(),
          ),
        ],
      );
}
