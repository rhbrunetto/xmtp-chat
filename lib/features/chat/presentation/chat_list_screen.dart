import 'package:auto_route/auto_route.dart';
import 'package:eth_chat/di.dart';
import 'package:eth_chat/features/chat/data/chat_repository.dart';
import 'package:eth_chat/features/session/data/session.dart';
import 'package:eth_chat/features/session/services/session_cubit.dart';
import 'package:eth_chat/routes.gr.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class ChatListScreen extends StatelessWidget {
  const ChatListScreen({super.key});

  void _onNewChat() {}

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
                  onTap: () => context.router.push(
                    ConvoRoute(recipient: recipient),
                  ),
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
