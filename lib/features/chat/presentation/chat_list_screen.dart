import 'package:auto_route/auto_route.dart';
import 'package:eth_chat/di.dart';
import 'package:eth_chat/features/chat/data/chat_repository.dart';
import 'package:eth_chat/features/chat/presentation/widgets/new_chat_dialog.dart';
import 'package:eth_chat/features/session/data/session.dart';
import 'package:eth_chat/features/session/services/session_cubit.dart';
import 'package:eth_chat/routes.gr.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class ChatListScreen extends StatefulWidget {
  const ChatListScreen({super.key});

  @override
  State<ChatListScreen> createState() => _State();
}

class _State extends State<ChatListScreen> {
  void _openChat(String recipient) =>
      context.router.push(ConvoRoute(recipient: recipient));

  Future<void> _onNewChat() async {
    final recipient = await showDialog(
      context: context,
      builder: (context) => const NewChatDialog(),
    );
    if (recipient == null) return;
    _openChat(recipient);
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
        body: StreamBuilder(
          stream: sl<ChatRepository>()
              .watchContacts(context.read<Session>().address),
          builder: (context, snapshot) {
            final chats = snapshot.data;

            if (snapshot.hasError) {
              return const Center(
                child: Text('Failed to load chats'),
              );
            }

            if (chats == null) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            return ListView.builder(
              itemCount: chats.length,
              itemBuilder: (context, index) {
                final recipient = chats.elementAt(index).recipient;

                return ListTile(
                  title: Text(recipient),
                  onTap: () => _openChat(recipient),
                );
              },
            );
          },
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
