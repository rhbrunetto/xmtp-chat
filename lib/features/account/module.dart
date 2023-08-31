import 'package:eth_chat/di.dart';
import 'package:eth_chat/features/account/services/account_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nested/nested.dart';

class AccountModule extends SingleChildStatelessWidget {
  const AccountModule({super.key, super.child});

  @override
  Widget buildWithChild(BuildContext context, Widget? child) => BlocProvider(
        create: (context) => sl<AccountBloc>(),
        child: child,
      );
}

class LogoutListener extends SingleChildStatelessWidget {
  const LogoutListener({
    super.key,
    super.child,
    required this.onLogout,
  });

  final ValueSetter<BuildContext> onLogout;

  @override
  Widget buildWithChild(BuildContext context, Widget? child) =>
      BlocListener<AccountBloc, AccountState>(
        listenWhen: (s1, s2) => s1 != s2,
        listener: (context, state) => state.whenOrNull(
          failed: () => onLogout(context),
        ),
        child: child,
      );
}
