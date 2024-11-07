import 'dart:io';

class ThemeConfig {
  void createThemeFile(String appName, String themeStyle, String? primaryColor,
      String? secondaryColor, String? textColor) {
    // Ensure the core directory exists
    final coreDir = '$appName/lib/core';
    final themeFilePath = '$coreDir/theme.dart';

    if (!Directory(coreDir).existsSync()) {
      Directory(coreDir).createSync(recursive: true);
      print("lib/core directory created.");
    }

    final file = File(themeFilePath);

    // Define default color settings
    final primary =
        _getColor(primaryColor, '0xFFEF7D30'); // Default primary color
    final secondary =
        _getColor(secondaryColor, '0xFF5925DC'); // Default secondary color
    final text = _getTextColor(textColor, themeStyle);

    // Generate the theme content
    String themeContent =
        _generateThemeContent(primary, secondary, text, themeStyle);

    // Write to the file
    file.writeAsStringSync(themeContent);
    print("Theme file created at: $themeFilePath");
  }

  String _getColor(String? color, String defaultColor) {
    return color != null
        ? 'Color(0xFF${color.replaceFirst('#', '')})'
        : 'Color($defaultColor)';
  }

  String _getTextColor(String? textColor, String themeStyle) {
    return textColor != null
        ? 'Color(0xFF${textColor.replaceFirst('#', '')})'
        : (themeStyle == 'Dark' ? 'Colors.white' : 'Colors.black');
  }

  String _generateThemeContent(
      String primary, String secondary, String text, String themeStyle) {
    return '''
import 'package:flutter/material.dart';

class AppTheme {
  static final ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: $primary,
    colorScheme: ColorScheme.fromSwatch().copyWith(
      primary: $primary,
      secondary: $secondary,
      background: Color(0xFFFFFFFF),
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: $primary, // AppBar color
      foregroundColor: Colors.white, // Text color on AppBar
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        primary: $primary, // Button color
        onPrimary: Colors.white, // Text color on button
      ),
    ),
    textTheme: TextTheme(
      bodyText1: TextStyle(color: $text),
      // Add other text styles if needed
    ),
  );

  static final ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: $primary,
    colorScheme: ColorScheme.fromSwatch(brightness: Brightness.dark).copyWith(
      primary: $primary,
      secondary: $secondary,
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: $primary, // AppBar color
      foregroundColor: Colors.white, // Text color on AppBar
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        primary: $primary, // Button color
        onPrimary: Colors.white, // Text color on button
      ),
    ),
    textTheme: TextTheme(
      bodyText1: TextStyle(color: Colors.white), // Adjust for dark theme
      // Add other text styles if needed
    ),
  );

  static final ThemeData customTheme = ThemeData(
    brightness: ${themeStyle == 'Dark' ? 'Brightness.dark' : 'Brightness.light'},
    primaryColor: $primary,
    colorScheme: ColorScheme.fromSwatch().copyWith(
      primary: $primary,
      secondary: $secondary,
      background: Color(0xFFFFFFFF),
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: $primary, // AppBar color
      foregroundColor: Colors.white, // Text color on AppBar
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        primary: $primary, // Button color
        onPrimary: Colors.white, // Text color on button
      ),
    ),
    textTheme: TextTheme(
      bodyText1: TextStyle(color: $text),
      // Add other text styles if needed
    ),
  );
}
''';
  }
}


// import 'dart:io';

// class ThemeConfig {
//   void createThemeFile(String appName, String themeStyle, String? primaryColor,
//       String? secondaryColor, String? textColor) {
//     // Ensure core directory exists
//     final coreDir = '$appName/lib/core';
//     final themeFilePath = '$coreDir/theme.dart';

//     if (!Directory(coreDir).existsSync()) {
//       Directory(coreDir).createSync(recursive: true);
//       print("lib/core directory created.");
//     }

//     final file = File(themeFilePath);

//     // Define default color settings
//     final primary = primaryColor != null
//         ? 'Color(0xFF${primaryColor.replaceFirst('#', '')})'
//         : 'Colors.blue';
//     final secondary = secondaryColor != null
//         ? 'Color(0xFF${secondaryColor.replaceFirst('#', '')})'
//         : 'Colors.blueAccent';
//     final text = textColor != null
//         ? 'Color(0xFF${textColor.replaceFirst('#', '')})'
//         : (themeStyle == 'Dark' ? 'Colors.white' : 'Colors.black');

//     // Theme content template
//     String themeContent = '''
// import 'package:flutter/material.dart';

// class AppTheme {
//   static final ThemeData lightTheme = ThemeData(
//     brightness: Brightness.light,
//     primaryColor: $primary,
//     colorScheme: ColorScheme.fromSwatch().copyWith(
//       primary: $primary,
//       secondary: $secondary,
//     ),
//     textTheme: TextTheme(
//       bodyText1: TextStyle(color: $text),
//     ),
//   );

//   static final ThemeData darkTheme = ThemeData(
//     brightness: Brightness.dark,
//     primaryColor: $primary,
//     colorScheme: ColorScheme.fromSwatch(brightness: Brightness.dark).copyWith(
//       primary: $primary,
//       secondary: $secondary,
//     ),
//     textTheme: TextTheme(
//       bodyText1: TextStyle(color: $text),
//     ),
//   );

//   static final ThemeData customTheme = ThemeData(
//     brightness: ${themeStyle == 'Dark' ? 'Brightness.dark' : 'Brightness.light'},
//     primaryColor: $primary,
//     colorScheme: ColorScheme.fromSwatch().copyWith(
//       primary: $primary,
//       secondary: $secondary,
//     ),
//     textTheme: TextTheme(
//       bodyText1: TextStyle(color: $text),
//     ),
//   );
// }
//   ''';

//     file.writeAsStringSync(themeContent);
//     print("Theme file created at: $themeFilePath");
//   }
// }
