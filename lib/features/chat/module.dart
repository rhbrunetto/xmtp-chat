import 'package:eth_chat/core/widgets/loading.dart';
import 'package:eth_chat/di.dart';
import 'package:eth_chat/features/chat/data/convo_repository.dart';
import 'package:eth_chat/features/chat/data/message_repository.dart';
import 'package:eth_chat/features/chat/presentation/widgets/retry_xmtp_widget.dart';
import 'package:eth_chat/features/chat/services/chat_service.dart';
import 'package:eth_chat/features/chat/services/xmtp_bloc.dart';
import 'package:eth_chat/features/session/data/session.dart';
import 'package:eth_chat/features/session/module.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nested/nested.dart';
import 'package:provider/provider.dart';

class ChatModule extends SingleChildStatefulWidget {
  const ChatModule({super.key, super.child});

  @override
  State<StatefulWidget> createState() => _State();
}

class _State extends SingleChildState<ChatModule> {
  late final XmtpBloc _xmtpBloc;

  @override
  void initState() {
    super.initState();
    _xmtpBloc = sl<XmtpBloc>();
    _init();
  }

  void _init() => _xmtpBloc.initialize(context.read<Session>());

  @override
  Widget buildWithChild(BuildContext context, Widget? child) =>
      BlocBuilder<XmtpBloc, XmtpState>(
        builder: (context, state) => state.when(
          loading: () => const LoadingWidget(),
          failed: () => RetryXmtpWidget(onRetry: _init),
          success: (isolate) => MultiProvider(
            providers: [
              Provider.value(value: isolate),
              Provider(
                lazy: false,
                create: (context) => sl<ChatService>(param1: isolate),
              ),
            ],
            child: LogoutListener(
              onLogout: (_) {
                isolate.kill();
                sl<MessageRepository>().clear();
                sl<ConvoRepository>().clear();
              },
              child: child,
            ),
          ),
        ),
      );
}
