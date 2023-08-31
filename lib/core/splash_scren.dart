import 'package:auto_route/auto_route.dart';
import 'package:eth_chat/routes.gr.dart';
import 'package:flutter/material.dart';

@RoutePage()
class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  static const route = SplashRoute.new;

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
