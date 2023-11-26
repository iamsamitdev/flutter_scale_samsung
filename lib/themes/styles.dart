import 'package:flutter/material.dart';
import 'colors.dart';

class AppTheme {
  
  // Light theme
  static final ThemeData lightTheme = ThemeData(
    fontFamily: 'IBMPlexSansThai',
    useMaterial3: false,
    primaryColor: primary,
    primaryColorDark: primaryDark,
    primaryColorLight: primaryLight,
    hoverColor: divider,
    hintColor: primaryDark,
    colorScheme: const ColorScheme.light(primary: primary),
    iconTheme: const IconThemeData(color: primaryText),
    scaffoldBackgroundColor: icons,
    appBarTheme: const AppBarTheme(
      titleTextStyle: TextStyle(
        fontFamily: 'IBMPlexSansThai',
        color: primaryLight,
        fontWeight: FontWeight.bold,
        fontSize: 20,
      ),
      backgroundColor: primary,
      foregroundColor: icons,
      iconTheme: IconThemeData(color: icons),
    )
  );

  // Dark theme
  static final ThemeData darkTheme = ThemeData(
    fontFamily: 'IBMPlexSansThai',
    useMaterial3: false,
    primaryColor: primary,
    primaryColorDark: primaryDark,
    primaryColorLight: primaryLight,
    hoverColor: divider,
    hintColor: accent,
    colorScheme: const ColorScheme.dark(primary: icons),
    iconTheme: const IconThemeData(color: icons),
    scaffoldBackgroundColor: primaryText,
    appBarTheme: const AppBarTheme(
      titleTextStyle: TextStyle(
        fontFamily: 'IBMPlexSansThai',
        color: icons,
        fontWeight: FontWeight.bold,
        fontSize: 20,
      ),
      backgroundColor: primaryText,
      foregroundColor: icons,
      iconTheme: IconThemeData(color: icons),
    )
  );

}