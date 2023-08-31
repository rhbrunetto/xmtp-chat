import 'package:auto_route/auto_route.dart';
import 'package:eth_chat/core/authenticated_flow.dart';
import 'package:eth_chat/core/sign_in_flow.dart';
import 'package:eth_chat/core/splash_scren.dart';
import 'package:eth_chat/features/account/module.dart';
import 'package:eth_chat/features/account/services/account_bloc.dart';
import 'package:eth_chat/routes.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (!kIsWeb) {
    await SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    await SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
  }

  runApp(
    MultiProvider(
      providers: const [AccountModule()],
      child: const ChatApp(),
    ),
  );
}

class ChatApp extends StatefulWidget {
  const ChatApp({super.key});

  @override
  State<ChatApp> createState() => _State();
}

class _State extends State<ChatApp> {
  final _router = AppRouter();

  @override
  Widget build(BuildContext context) => BlocBuilder<AccountBloc, AccountState>(
        builder: (context, state) => MaterialApp.router(
          routeInformationParser: _router.defaultRouteParser(),
          routerDelegate: AutoRouterDelegate.declarative(
            _router,
            routes: (_) => [
              state.map(
                loading: (_) => SplashScreen.route(),
                failed: (_) => SignInFlowScreen.route(),
                success: (_) => AuthenticatedFlowScreen.route(),
              ),
            ],
          ),
          debugShowCheckedModeBanner: false,
          title: 'Orb Chat',
        ),
      );
}
