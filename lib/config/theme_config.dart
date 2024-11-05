import 'dart:io';

class ThemeConfig {
  void createThemeFile(String appName, String themeStyle, String? primaryColor,
      String? secondaryColor, String? textColor) {
    // Ensure core directory exists
    final coreDir = '$appName/lib/core';
    final themeFilePath = '$coreDir/theme.dart';

    if (!Directory(coreDir).existsSync()) {
      Directory(coreDir).createSync(recursive: true);
      print("lib/core directory created.");
    }

    final file = File(themeFilePath);

    // Define default color settings
    final primary = primaryColor != null
        ? 'Color(0xFF${primaryColor.replaceFirst('#', '')})'
        : 'Colors.blue';
    final secondary = secondaryColor != null
        ? 'Color(0xFF${secondaryColor.replaceFirst('#', '')})'
        : 'Colors.blueAccent';
    final text = textColor != null
        ? 'Color(0xFF${textColor.replaceFirst('#', '')})'
        : (themeStyle == 'Dark' ? 'Colors.white' : 'Colors.black');

    // Theme content template
    String themeContent = '''
import 'package:flutter/material.dart';

class AppTheme {
  static final ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: $primary,
    colorScheme: ColorScheme.fromSwatch().copyWith(
      primary: $primary,
      secondary: $secondary,
    ),
    textTheme: TextTheme(
      bodyText1: TextStyle(color: $text),
    ),
  );

  static final ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: $primary,
    colorScheme: ColorScheme.fromSwatch(brightness: Brightness.dark).copyWith(
      primary: $primary,
      secondary: $secondary,
    ),
    textTheme: TextTheme(
      bodyText1: TextStyle(color: $text),
    ),
  );

  static final ThemeData customTheme = ThemeData(
    brightness: ${themeStyle == 'Dark' ? 'Brightness.dark' : 'Brightness.light'},
    primaryColor: $primary,
    colorScheme: ColorScheme.fromSwatch().copyWith(
      primary: $primary,
      secondary: $secondary,
    ),
    textTheme: TextTheme(
      bodyText1: TextStyle(color: $text),
    ),
  );
}
  ''';

    file.writeAsStringSync(themeContent);
    print("Theme file created at: $themeFilePath");
  }
}
