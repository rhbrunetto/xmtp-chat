import 'package:auto_route/auto_route.dart';

import 'routes.gr.dart';

@AutoRouterConfig(
  replaceInRouteName: 'Screen,Route',
  deferredLoading: false,
)
class AppRouter extends $AppRouter {
  @override
  RouteType get defaultRouteType => const RouteType.material();

  @override
  final List<AutoRoute> routes = [
    AutoRoute(page: SplashRoute.page, initial: true),
    AutoRoute(
      page: SignInFlowRoute.page,
      children: [
        AutoRoute(path: '', page: WalletConnectRoute.page),
      ],
    ),
    AutoRoute(
      page: AuthenticatedFlowRoute.page,
      children: [
        AutoRoute(path: '', page: ChatListRoute.page),
        AutoRoute(page: MessageRoute.page),
      ],
    ),
  ];
}
