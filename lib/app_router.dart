import 'package:go_router/go_router.dart';
import 'package:iz_web_flutter/screen/test/test_screen.dart';

import 'screen/splatbannermaker/badge_select_screen.dart';
import 'screen/splatbannermaker/banner_select_screen.dart';
import 'screen/splatbannermaker/splatbannermaker_screen.dart';

class RouteNames {
  static const String splatbannermaker_screen = 'SplatBannerMakerScreen';
  static const String banner_select_screen = 'BannerSelectScreen';
  static const String badge_select_screen = 'BadgeSelectScreen';

  static const String test_screen = 'TestScreen';
}

class AppRouter {
  final GoRouter router =
      GoRouter(initialLocation: '/splatbannermaker', routes: [
    GoRoute(path: '/', builder: (context, state) => SplatBannerMakerScreen()),
    GoRoute(
        name: RouteNames.splatbannermaker_screen,
        path: '/splatbannermaker',
        builder: (context, state) => SplatBannerMakerScreen(),
        routes: [
          GoRoute(
              name: RouteNames.banner_select_screen,
              path: 'bannerselect',
              builder: (context, state) => BannerSelectScreen()),
          GoRoute(
              name: RouteNames.badge_select_screen,
              path: 'badgeselect',
              builder: (context, state) => BadgeSelectScreen()),
        ]),
    GoRoute(
        name: RouteNames.test_screen,
        path: '/test',
        builder: (context, state) => TestScreen())
  ]);
}
