import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nested/nested.dart';
import 'package:provider/provider.dart';

import '../../di.dart';
import '../session/data/session.dart';
import '../session/module.dart';
import 'data/convo_repository.dart';
import 'data/message_repository.dart';
import 'presentation/widgets/xmtp_loading_widget.dart';
import 'presentation/widgets/xmtp_retry_widget.dart';
import 'services/chat_service.dart';
import 'services/xmtp_bloc.dart';

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
    _initIsolate();
  }

  @override
  void dispose() {
    super.dispose();
    _xmtpBloc.close();
  }

  void _initIsolate() => _xmtpBloc.initializeIsolate(context.read<Session>());

  @override
  Widget buildWithChild(BuildContext context, Widget? child) =>
      BlocBuilder<XmtpBloc, XmtpState>(
        bloc: _xmtpBloc,
        builder: (context, state) => state.when(
          loading: () => const XmtpLoadingWidget(),
          failed: () => XmtpRetryWidget(onRetry: _initIsolate),
          success: (pair) => MultiProvider(
            providers: [
              Provider.value(value: pair.isolate),
              Provider(
                lazy: false,
                create: (context) => sl<ChatService>(param1: pair.isolate),
              ),
            ],
            child: LogoutListener(
              onLogout: (_) async {
                await sl<MessageRepository>().clear();
                await sl<ConvoRepository>().clear();
                await _xmtpBloc.disconnect();
              },
              child: child,
            ),
          ),
        ),
      );
}
