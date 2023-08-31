import 'package:dfunc/dfunc.dart';
import 'package:eth_chat/features/account/data/my_account.dart';
import 'package:eth_chat/features/account/services/account_bloc.dart';
import 'package:eth_chat/features/chat/module.dart';
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
  Widget build(BuildContext context) => BlocBuilder<AccountBloc, AccountState>(
        builder: (context, state) {
          final account = state.whenOrNull(success: identity);
          if (account == null) return const SizedBox.shrink();

          return MultiProvider(
            providers: [
              Provider<MyAccount>.value(value: account),
              const ChatModule(),
            ],
            child: const AutoRouter(),
          );
        },
      );
}
