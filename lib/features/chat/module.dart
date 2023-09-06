import 'package:eth_chat/di.dart';
import 'package:eth_chat/features/chat/services/chat_bloc.dart';
import 'package:eth_chat/features/session/data/session.dart';
import 'package:eth_chat/features/session/module.dart';
import 'package:eth_chat/features/chat/data/chat_repository.dart';
import 'package:eth_chat/features/chat/services/chat_watcher.dart';
import 'package:flutter/material.dart';
import 'package:nested/nested.dart';
import 'package:provider/provider.dart';

class ChatModule extends SingleChildStatelessWidget {
  const ChatModule({super.key, super.child});

  @override
  Widget buildWithChild(BuildContext context, Widget? child) => MultiProvider(
        providers: [
          Provider<ChatBloc>(
            create: (context) => sl<ChatBloc>(
              param1: context.read<Session>(),
            ),
          ),
          Provider<ChatWatcher>(
            lazy: false,
            create: (context) => sl<ChatWatcher>()..watch(),
            dispose: (_, watcher) => watcher.dispose(),
          ),
        ],
        child: LogoutListener(
          onLogout: (_) => sl<ChatRepository>().clear(),
          child: child,
        ),
      );
}
