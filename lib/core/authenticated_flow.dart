import 'package:dfunc/dfunc.dart';
import 'package:eth_chat/features/chat/module.dart';
import 'package:eth_chat/features/session/data/session.dart';
import 'package:eth_chat/features/session/services/session_cubit.dart';
import 'package:eth_chat/features/xmtp/module.dart';
import 'package:eth_chat/routes.gr.dart';
import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:provider/provider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class AuthenticatedFlowScreen extends StatelessWidget {
  const AuthenticatedFlowScreen({super.key});

  static const route = AuthenticatedFlowRoute.new;

  @override
  Widget build(BuildContext context) => BlocBuilder<SessionCubit, SessionState>(
        builder: (context, state) {
          final account = state.whenOrNull(success: identity);
          if (account == null) return const SizedBox.shrink();

          return MultiProvider(
            providers: [
              Provider<Session>.value(value: account),
              const XmtpModule(),
              const ChatModule(),
            ],
            child: const AutoRouter(),
          );
        },
      );
}
