import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:iz_web_flutter/screen/chat/chat_screen.dart';
import 'package:iz_web_flutter/screen/game/adventure_game_screen.dart';
import 'package:iz_web_flutter/screen/portfolio/portfolio_screen.dart';
import 'package:iz_web_flutter/screen/test/test_screen.dart';

import 'screen/splatbannermaker/badge_select_screen.dart';
import 'screen/splatbannermaker/banner_select_screen.dart';
import 'screen/splatbannermaker/splatbannermaker_screen.dart';

class RouteNames {
  static const String RN_splatbannermaker_screen = 'SplatBannerMakerScreen';
  static const String RN_banner_select_screen = 'BannerSelectScreen';
  static const String RN_badge_select_screen = 'BadgeSelectScreen';




  static const String RN_bomb_game_screen = 'BombGameScreen';

  static const String RN_test_screen = 'TestScreen';

  static const String RN_chat_screen = 'ChatScreen';

  static const String RN_portfolio_screen = 'PortfolioScreen';
}

class AppRouter {
  final GoRouter router = GoRouter(initialLocation: '/splatbannermaker', routes: [
    GoRoute(path: '/', pageBuilder: defaultPageBuilder(SplatBannerMakerScreen())),
    GoRoute(name: RouteNames.RN_splatbannermaker_screen, path: '/splatbannermaker', pageBuilder: defaultPageBuilder(SplatBannerMakerScreen()), routes: [
      GoRoute(name: RouteNames.RN_banner_select_screen, path: 'bannerselect', builder: (context, state) => BannerSelectScreen()),
      GoRoute(name: RouteNames.RN_badge_select_screen, path: 'badgeselect', builder: (context, state) => BadgeSelectScreen()),
    ]),
    GoRoute(name: RouteNames.RN_bomb_game_screen, path: '/bombgame', pageBuilder: defaultPageBuilder(BombGameScreen())),
    GoRoute(name: RouteNames.RN_chat_screen, path: '/chat', pageBuilder: defaultPageBuilder(ChatScreen())),
    GoRoute(name: RouteNames.RN_test_screen, path: '/test', pageBuilder: defaultPageBuilder(TestScreen())),
    GoRoute(name: RouteNames.RN_portfolio_screen, path: '/portfolio', pageBuilder: defaultPageBuilder(PortfolioScreen()))
  ]);
}

Page<dynamic> Function(BuildContext, GoRouterState) defaultPageBuilder<T>(Widget child, {String? type}) => (BuildContext context, GoRouterState state) {
      return buildPageWithDefaultTransition<T>(context: context, state: state, child: child, type: type);
    };

CustomTransitionPage buildPageWithDefaultTransition<T>({required BuildContext context, required GoRouterState state, required Widget child, String? type}) {
  return CustomTransitionPage<T>(
      key: state.pageKey,
      child: child,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        switch (type) {
          case 'fade':
            return FadeTransition(opacity: animation, child: child);
          case 'rotation':
            return RotationTransition(turns: animation, child: child);
          case 'size':
            return SizeTransition(sizeFactor: animation, child: child);
          case 'scale':
            return ScaleTransition(scale: animation, child: child);
          default:
            return FadeTransition(opacity: animation, child: child);
        }
      });
}
