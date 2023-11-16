import 'package:flutter/material.dart';
import 'package:iz_web_flutter/constant/app_constants.dart';
import 'package:iz_web_flutter/widget/scaffold/web_responsive_scaffold.dart';

import '../../widget/navigation_widget.dart';

class TestScreen extends StatefulWidget {
  const TestScreen({super.key});

  @override
  State<TestScreen> createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
  @override
  Widget build(BuildContext context) {
    return WebResponsiveScaffold(
      navigationWidget: NavigationWidget(
        menuCode: MenuCodes.TEST,
        showBackColor: true,
      ),
    );
  }
}
