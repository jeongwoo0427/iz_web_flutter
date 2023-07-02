import 'package:flutter/material.dart';
import 'package:iz_web_flutter/widget/navigation_widget.dart';
import 'package:responsive_framework/responsive_framework.dart';

import '../../constant/app_constants.dart';
import '../../constant/app_font_family.dart';
import 'constrained_layout.dart';

class WebResponsiveScaffold extends StatelessWidget {
  final Widget? navigationWidget;
  final Widget? body;

  const WebResponsiveScaffold({super.key, this.navigationWidget,this.body});

  @override
  Widget build(BuildContext context) {
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      body: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          if (navigationWidget != null) navigationWidget!,
          Expanded(
              child: DefaultTextStyle(
            style: TextStyle(
              color: colorScheme.onBackground,
              fontWeight: FontWeight.w800,
              fontFamily: AppFontFamily.cookie_run,
              fontSize: ResponsiveValue<double>(context,
                  defaultValue: 24,
                  valueWhen: [
                    const Condition.smallerThan(name: TABLET, value: 18)
                  ]).value,
            ),
            child: ListView(
              padding: EdgeInsets.symmetric(horizontal: globalHorizonPadding15),
              children: [ConstrainedLayout(child: body ?? Container())],
            ),
          ))
        ],
      ),
    );
  }
}
