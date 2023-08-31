// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i7;
import 'package:eth_chat/core/authenticated_flow.dart' as _i1;
import 'package:eth_chat/core/sign_in_flow.dart' as _i4;
import 'package:eth_chat/core/splash_scren.dart' as _i5;
import 'package:eth_chat/features/chat/presentation/chat_list_screen.dart'
    as _i2;
import 'package:eth_chat/features/chat/presentation/convo_screen.dart' as _i3;
import 'package:eth_chat/features/wallet_connect/presentation/wallet_connect_screen.dart'
    as _i6;
import 'package:flutter/material.dart' as _i8;

abstract class $AppRouter extends _i7.RootStackRouter {
  $AppRouter({super.navigatorKey});

  @override
  final Map<String, _i7.PageFactory> pagesMap = {
    AuthenticatedFlowRoute.name: (routeData) {
      return _i7.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i1.AuthenticatedFlowScreen(),
      );
    },
    ChatListRoute.name: (routeData) {
      return _i7.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i2.ChatListScreen(),
      );
    },
    ConvoRoute.name: (routeData) {
      final args = routeData.argsAs<ConvoRouteArgs>();
      return _i7.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i3.ConvoScreen(
          key: args.key,
          recipient: args.recipient,
        ),
      );
    },
    SignInFlowRoute.name: (routeData) {
      return _i7.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i4.SignInFlowScreen(),
      );
    },
    SplashRoute.name: (routeData) {
      return _i7.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i5.SplashScreen(),
      );
    },
    WalletConnectRoute.name: (routeData) {
      return _i7.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i6.WalletConnectScreen(),
      );
    },
  };
}

/// generated route for
/// [_i1.AuthenticatedFlowScreen]
class AuthenticatedFlowRoute extends _i7.PageRouteInfo<void> {
  const AuthenticatedFlowRoute({List<_i7.PageRouteInfo>? children})
      : super(
          AuthenticatedFlowRoute.name,
          initialChildren: children,
        );

  static const String name = 'AuthenticatedFlowRoute';

  static const _i7.PageInfo<void> page = _i7.PageInfo<void>(name);
}

/// generated route for
/// [_i2.ChatListScreen]
class ChatListRoute extends _i7.PageRouteInfo<void> {
  const ChatListRoute({List<_i7.PageRouteInfo>? children})
      : super(
          ChatListRoute.name,
          initialChildren: children,
        );

  static const String name = 'ChatListRoute';

  static const _i7.PageInfo<void> page = _i7.PageInfo<void>(name);
}

/// generated route for
/// [_i3.ConvoScreen]
class ConvoRoute extends _i7.PageRouteInfo<ConvoRouteArgs> {
  ConvoRoute({
    _i8.Key? key,
    required String recipient,
    List<_i7.PageRouteInfo>? children,
  }) : super(
          ConvoRoute.name,
          args: ConvoRouteArgs(
            key: key,
            recipient: recipient,
          ),
          initialChildren: children,
        );

  static const String name = 'ConvoRoute';

  static const _i7.PageInfo<ConvoRouteArgs> page =
      _i7.PageInfo<ConvoRouteArgs>(name);
}

class ConvoRouteArgs {
  const ConvoRouteArgs({
    this.key,
    required this.recipient,
  });

  final _i8.Key? key;

  final String recipient;

  @override
  String toString() {
    return 'ConvoRouteArgs{key: $key, recipient: $recipient}';
  }
}

/// generated route for
/// [_i4.SignInFlowScreen]
class SignInFlowRoute extends _i7.PageRouteInfo<void> {
  const SignInFlowRoute({List<_i7.PageRouteInfo>? children})
      : super(
          SignInFlowRoute.name,
          initialChildren: children,
        );

  static const String name = 'SignInFlowRoute';

  static const _i7.PageInfo<void> page = _i7.PageInfo<void>(name);
}

/// generated route for
/// [_i5.SplashScreen]
class SplashRoute extends _i7.PageRouteInfo<void> {
  const SplashRoute({List<_i7.PageRouteInfo>? children})
      : super(
          SplashRoute.name,
          initialChildren: children,
        );

  static const String name = 'SplashRoute';

  static const _i7.PageInfo<void> page = _i7.PageInfo<void>(name);
}

/// generated route for
/// [_i6.WalletConnectScreen]
class WalletConnectRoute extends _i7.PageRouteInfo<void> {
  const WalletConnectRoute({List<_i7.PageRouteInfo>? children})
      : super(
          WalletConnectRoute.name,
          initialChildren: children,
        );

  static const String name = 'WalletConnectRoute';

  static const _i7.PageInfo<void> page = _i7.PageInfo<void>(name);
}
