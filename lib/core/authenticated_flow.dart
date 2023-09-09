import 'package:auto_route/auto_route.dart';
import 'package:dfunc/dfunc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import '../features/chat/module.dart';
import '../features/session/data/session.dart';
import '../features/session/services/session_cubit.dart';
import '../routes.gr.dart';

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
              const ChatModule(),
            ],
            child: const AutoRouter(),
          );
        },
      );
}
