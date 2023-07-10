import 'package:go_router/go_router.dart';
import 'package:iz_web_flutter/screen/portfolio/portfolio_screen.dart';
import 'package:iz_web_flutter/screen/test/test_screen.dart';

import 'screen/splatbannermaker/badge_select_screen.dart';
import 'screen/splatbannermaker/banner_select_screen.dart';
import 'screen/splatbannermaker/splatbannermaker_screen.dart';

class RouteNames {
  static const String RN_splatbannermaker_screen = 'SplatBannerMakerScreen';
  static const String RN_banner_select_screen = 'BannerSelectScreen';
  static const String RN_badge_select_screen = 'BadgeSelectScreen';

  static const String RN_test_screen = 'TestScreen';

  static const String RN_portfolio_screen = 'PortfolioScreen';
}

class AppRouter {
  final GoRouter router =
      GoRouter(initialLocation: '/splatbannermaker', routes: [
    GoRoute(path: '/', builder: (context, state) => SplatBannerMakerScreen()),
    GoRoute(
        name: RouteNames.RN_splatbannermaker_screen,
        path: '/splatbannermaker',
        builder: (context, state) => SplatBannerMakerScreen(),
        routes: [
          GoRoute(
              name: RouteNames.RN_banner_select_screen,
              path: 'bannerselect',
              builder: (context, state) => BannerSelectScreen()),
          GoRoute(
              name: RouteNames.RN_badge_select_screen,
              path: 'badgeselect',
              builder: (context, state) => BadgeSelectScreen()),
        ]),
    GoRoute(name: RouteNames.RN_test_screen, path: '/test', builder: (context, state) => TestScreen()),
    GoRoute(name: RouteNames.RN_portfolio_screen, path: '/portfolio', builder: (context, state) => PortfolioScreen())
  ]);
}
