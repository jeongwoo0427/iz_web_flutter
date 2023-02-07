import 'package:flutter/material.dart';

PreferredSizeWidget getDefaultAppbar(
    BuildContext context, {
      Color? backgroundColor,
      required Widget title,
      double? toolbarHeight,
      Widget? leading,
      Widget? flexibleSpace,
      List<Widget>? actions,
      double elevation = 3,
    }) {
  ThemeData theme = Theme.of(context);
  return AppBar(
    backgroundColor: backgroundColor ?? theme.colorScheme.surface,
    centerTitle: true,
    title:title,
    toolbarHeight: toolbarHeight,
    leading: leading,
    flexibleSpace: flexibleSpace,
    actions: actions,
    elevation: elevation,
  );
}
