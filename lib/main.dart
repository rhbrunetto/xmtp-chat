import 'package:auto_route/auto_route.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

import 'core/authenticated_flow.dart';
import 'core/sign_in_flow.dart';
import 'core/splash_scren.dart';
import 'di.dart';
import 'features/session/module.dart';
import 'features/session/services/session_cubit.dart';
import 'routes.dart';
import 'ui/theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (!kIsWeb) {
    await SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    await SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
  }

  await configureDependencies();

  runApp(
    MultiProvider(
      providers: const [
        SessionModule(),
      ],
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
  Widget build(BuildContext context) => BlocBuilder<SessionCubit, SessionState>(
        builder: (context, state) => MaterialApp.router(
          title: 'ETH Chat',
          theme: const EthTheme().toMaterialTheme(),
          debugShowCheckedModeBanner: false,
          supportedLocales: AppLocalizations.supportedLocales,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
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
        ),
      );
}
