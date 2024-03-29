import 'package:flutter/material.dart';
import 'package:iz_web_flutter/app_router.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'constant/app_themes.dart';
import 'core/service/socket/chat_socket_service.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  final ChatSocketService socket = ChatSocketService();
  socket.connect();
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'IZWeb',
      builder: (context, widget) => ResponsiveWrapper.builder(
          ClampingScrollWrapper.builder(context, widget!),
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
      routerConfig: AppRouter().router,
    );
  }
}
