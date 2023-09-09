import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../features/wallet_connect/module.dart';
import '../routes.gr.dart';

@RoutePage()
class SignInFlowScreen extends StatelessWidget {
  const SignInFlowScreen({super.key});

  static const route = SignInFlowRoute.new;

  @override
  Widget build(BuildContext context) => MultiProvider(
        providers: const [WalletConnectModule()],
        child: const AutoRouter(),
      );
}
