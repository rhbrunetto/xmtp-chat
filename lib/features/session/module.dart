import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nested/nested.dart';

import '../../di.dart';
import 'services/session_cubit.dart';

class SessionModule extends SingleChildStatelessWidget {
  const SessionModule({super.key, super.child});

  @override
  Widget buildWithChild(BuildContext context, Widget? child) => BlocProvider(
        create: (context) => sl<SessionCubit>(),
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
      BlocListener<SessionCubit, SessionState>(
        listenWhen: (s1, s2) => s1 != s2,
        listener: (context, state) => state.whenOrNull(
          failed: () => onLogout(context),
        ),
        child: child,
      );
}
