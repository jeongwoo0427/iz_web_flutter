import 'package:flutter/material.dart';
import 'package:iz_web_flutter/screen/splatbannermaker/badge_select_screen.dart';
import 'package:responsive_framework/responsive_framework.dart';

import 'constant/app_themes.dart';
import 'constant/route_names.dart';
import 'screen/splatbannermaker/banner_select_screen.dart';
import 'screen/splatbannermaker/splatbannermaker_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'IZWeb',
        builder: (context, widget) => ResponsiveWrapper.builder(ClampingScrollWrapper.builder(context, widget!),
            defaultScale: true,
            minWidth: 330,
            defaultName: MOBILE,
            breakpoints: [
              const ResponsiveBreakpoint.resize(330),
              const ResponsiveBreakpoint.resize(480, name: MOBILE),
              const ResponsiveBreakpoint.resize(850, name: TABLET),
              const ResponsiveBreakpoint.resize(1080, name: DESKTOP),
            ]),
        theme: AppThemes.lightTheme,
        themeMode: ThemeMode.light,
        initialRoute: RouteNames.splatbannermaker_screen,
        routes: {
          RouteNames.splatbannermaker_screen: (context) => SplatBannerMakerScreen(),
          RouteNames.banner_select_screen : (context) => BannerSelectScreen(),
          RouteNames.badge_select_screen : (context) => BadgeSelectScreen()
        },
        //home: SplatBannerMakerScreen()
    );
  }
}
