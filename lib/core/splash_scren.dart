import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../routes.gr.dart';
import 'widgets/loading_widget.dart';

@RoutePage()
class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  static const route = SplashRoute.new;

  @override
  Widget build(BuildContext context) => const LoadingWidget();
}
