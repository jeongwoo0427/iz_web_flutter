import 'package:flutter/material.dart';

import 'app_font_family.dart';

class AppThemes {
  ///LightTheme Colors
  static const Color _lightFontColor = Color(0xFF464646);
  static const Color _lightPrimaryColor = Color(0xFFFA9917);
  static const Color _lightOnPrimaryColor = Color(0xFFFAFCFF);
  static const Color _lightSecondaryColor = Color(0xFFE954FF);
  static const Color _lightTertiaryColor = Color(0xFFCA008A);
  static const Color _lightOnTertiaryColor = Color(0xFFFAFCFF);
  static const Color _lightOnSecondaryColor = _lightFontColor;
  static const Color _lightBackgroundColor = Color(0xFFF4F5FA);
  static const Color _lightOnBackgroundColor = _lightFontColor;
  static const Color _lightSurfaceColor = Color(0xFFFFFFFF);
  static const Color _lightOnSurfaceColor = _lightFontColor;

  static const TextStyle _lightHeadLine1Style = TextStyle(fontSize: 20.0, color: _lightOnBackgroundColor);
  static const TextStyle _lightBodyText1Style = TextStyle(fontSize: 17.0, color: _lightOnBackgroundColor);
  static const TextStyle _lightBodyText2Style = TextStyle(fontSize: 15.0, color: _lightOnBackgroundColor);

  ///DarkTheme Colors
  static const Color _darkFontColor = Color(0xFFDEDEDE);
  static const Color _darkPrimaryColor = Color(0xFF518CCE);
  static const Color _darkOnPrimaryColor = _darkFontColor;
  static const Color _darkSecondaryColor = Color(0xFF426A8E);
  static const Color _darkOnSecondaryColor = _darkFontColor;
  static const Color _darkTertiaryColor = Color(0xFF2C8FB6);
  static const Color _darkOntertiaryColor = Color(0xFFFAFCFF);
  static const Color _darkBackgroundColor = Color(0xFF4D4D5B);
  static const Color _darkOnBackgroundColor = _darkFontColor;
  static const Color _darkSurfaceColor = Color(0xFF616170);
  static const Color _darkOnSurfaceColor = _darkFontColor;
  static final TextStyle _darkHeadLine1Style = _lightHeadLine1Style.copyWith(color: _darkOnBackgroundColor);
  static final TextStyle _darkBody1TextStyle = _lightBodyText1Style.copyWith(color: _darkOnBackgroundColor);
  static final TextStyle _darkBodyText2Style = _lightBodyText2Style.copyWith(color: _darkOnBackgroundColor);

  //the light theme
  static final ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    fontFamily: AppFontFamily.cookie_run,
    scaffoldBackgroundColor: _lightBackgroundColor,
    appBarTheme: AppBarTheme().copyWith(backgroundColor: _lightBackgroundColor, foregroundColor: _lightFontColor),
    iconTheme: IconThemeData(color: _lightFontColor),
    tabBarTheme: TabBarTheme().copyWith(labelColor: _lightOnBackgroundColor),
    hoverColor: _lightPrimaryColor.withOpacity(0.4),
    splashColor: _lightSecondaryColor.withOpacity(0.4),
    colorScheme: ColorScheme.light().copyWith(
      brightness: Brightness.light,
      primary: _lightPrimaryColor,
      //상단바, 버튼색깔등에 지정됨
      onPrimary: _lightOnPrimaryColor,
      tertiary: _lightTertiaryColor,
      onTertiary: _lightOnTertiaryColor,
      background: _lightBackgroundColor,
      onBackground: _lightOnBackgroundColor,
      surface: _lightSurfaceColor,
      onSurface: _lightOnSurfaceColor,
      secondary: _lightSecondaryColor,
      //fab버튼, 리스트뷰풍선 색깔에 적용됨
      onSecondary: _lightOnSecondaryColor,
    ),
    textTheme: TextTheme().copyWith(
      headline1: _lightHeadLine1Style,
      bodyText1: _lightBodyText1Style,
      bodyText2: _lightBodyText2Style,
    ),
  );

  //the dark theme
  static final ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    fontFamily: AppFontFamily.cookie_run,
    appBarTheme: AppBarTheme().copyWith(backgroundColor: _darkBackgroundColor, foregroundColor: _darkFontColor),
    scaffoldBackgroundColor: _darkBackgroundColor,
    iconTheme: IconThemeData(color: _darkFontColor),
    tabBarTheme: TabBarTheme().copyWith(labelColor: _darkOnBackgroundColor),
    hoverColor: _darkPrimaryColor.withOpacity(0.4),
    splashColor: _darkSecondaryColor.withOpacity(0.4),
    colorScheme: ColorScheme.light().copyWith(
      brightness: Brightness.dark,
      primary: _darkPrimaryColor,
      //버튼색에 지정됨
      onPrimary: _darkOnPrimaryColor,
      secondary: _darkSecondaryColor,
      //fab버튼, 리스트뷰풍선 색깔에 적용됨
      onSecondary: _darkOnSecondaryColor,
      tertiary: _darkTertiaryColor,
      onTertiary: _darkOntertiaryColor,
      background: _darkBackgroundColor,
      onBackground: _darkOnBackgroundColor,
      surface: _darkSurfaceColor,
      //상단바색에 지정됨
      onSurface: _darkOnSurfaceColor,
    ),
    textTheme: TextTheme().copyWith(
      headline1: _darkHeadLine1Style,
      bodyText1: _darkBody1TextStyle,
      bodyText2: _darkBodyText2Style,
    ),
  );
}
