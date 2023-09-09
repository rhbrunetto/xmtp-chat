import 'package:auto_route/auto_route.dart';
import 'package:dfunc/dfunc.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/widgets/retry_widget.dart';
import '../../../l10n/l10n.dart';
import '../../../routes.gr.dart';
import '../../../ui/colors.dart';
import '../../../utils/extensions.dart';
import '../../session/services/session_cubit.dart';
import '../data/models/convo.dart';
import '../services/chat_service.dart';
import 'widgets/new_chat_dialog.dart';

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
          title: Text(context.l10n.chatTitle),
          actions: const [_PopMenu()],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: _onNewChat,
          foregroundColor: EthColors.mimiPink,
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
                return RetryWidget(
                  message: context.l10n.chatFailedToLoad,
                  onRetry: _service.refreshConversations,
                );
              }

              if (conversations.isEmpty) {
                return _EmptyConversations(onNewChat: _onNewChat);
              }

              return ListView.separated(
                itemCount: conversations.length,
                separatorBuilder: (context, _) => const Divider(),
                itemBuilder: (context, index) {
                  final conversation = conversations.elementAt(index);

                  return ListTile(
                    title: Text(
                      conversation.peer,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(fontSize: 16),
                    ),
                    subtitle: Text(
                      context.elapsedTimeFormatted(conversation.lastOpenedAt),
                    ),
                    onTap: () => _openChat(conversation.topic),
                    trailing: const Icon(Icons.chevron_right),
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
            child: Text(
              context.l10n.logout,
              style: const TextStyle(fontSize: 14),
            ),
            onTap: () => context.read<SessionCubit>().disconnect(),
          ),
        ],
      );
}

class _EmptyConversations extends StatelessWidget {
  const _EmptyConversations({
    required this.onNewChat,
  });

  final VoidCallback onNewChat;

  @override
  Widget build(BuildContext context) => Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              context.l10n.chatEmpty,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 16),
            TextButton(
              onPressed: onNewChat,
              child: Text(context.l10n.chatEmptyCTA),
            ),
            const SizedBox(height: kToolbarHeight),
          ],
        ),
      );
}
