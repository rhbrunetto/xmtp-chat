import 'package:auto_route/auto_route.dart';
import 'package:eth_chat/routes.gr.dart';
import 'package:flutter/material.dart';

@RoutePage()
class SignInFlowScreen extends StatelessWidget {
  const SignInFlowScreen({super.key});

  static const route = SignInFlowRoute.new;

  @override
  Widget build(BuildContext context) => const AutoRouter();
}
