import 'dart:io';

class MainPageEditor {
  void createMainPage(
    String appName,
    String routingStyle,
    String architecture,
    String stateManagement,
    String themeStyle,
  ) {
    final mainFilePath = '$appName/lib/main.dart';
    final mainFile = File(mainFilePath);

    // Choose the main content based on the routing style and state management
    String mainContent =
        _getMainContent(routingStyle, appName, stateManagement, themeStyle);

    // Write to the main.dart file
    mainFile.writeAsStringSync(mainContent);
    print(
        "main.dart created successfully with $routingStyle routing and $stateManagement state management.");
  }

  String _getMainContent(String routingStyle, String appName,
      String stateManagement, String themeStyle) {
    // Select the correct main.dart setup based on routing style and state management
    String stateSetup = _getStateManagementSetup(stateManagement);
    String mainRunApp = _getMainRunApp(stateManagement);

    final themeSetup = _getThemeSetup(themeStyle);

    return '''
import 'package:flutter/material.dart';
import 'package:$appName/core/routing/app_router.dart';
import 'package:$appName/core/theme.dart';
$stateSetup

void main() {
  $mainRunApp
}

class MyApp extends StatelessWidget {
  ${_getRouterSetup(routingStyle)}
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'My App',
      $themeSetup
      ${_getRouterConfig(routingStyle)}
    );
  }
}
''';
  }

  // Helper function to return the appropriate state management setup
  String _getStateManagementSetup(String stateManagement) {
    switch (stateManagement) {
      case 'Provider':
        return '''
import 'package:provider/provider.dart';
''';
      case 'Riverpod':
        return '''
import 'package:flutter_riverpod/flutter_riverpod.dart';
''';
      case 'GetX':
        return '''
import 'package:get/get.dart';
''';
      case 'Bloc':
        return '''
import 'package:flutter_bloc/flutter_bloc.dart';
''';
      default:
        return '';
    }
  }

  // Helper function to adjust the main runApp based on the state management solution
  String _getMainRunApp(String stateManagement) {
    switch (stateManagement) {
      case 'Provider':
        return 'runApp(MultiProvider(providers: [/* Add providers here */], child: MyApp()));';
      case 'Riverpod':
        return 'runApp(ProviderScope(child: MyApp()));';
      case 'GetX':
      case 'Bloc':
        return 'runApp(MyApp());';
      default:
        return 'runApp(MyApp());';
    }
  }

  // Helper function to get theme setup
  String _getThemeSetup(String themeStyle) {
    switch (themeStyle) {
      case 'Light':
        return 'theme: AppTheme.lightTheme,';
      case 'Dark':
        return 'theme: AppTheme.darkTheme,';
      case 'Custom':
        return 'theme: AppTheme.customTheme,';
      default:
        return 'ThemeData(primarySwatch: Colors.blue),';
    }
  }

  // Helper function to get routing configurations
  String _getRouterConfig(String routingStyle) {
    switch (routingStyle) {
      case 'Navigator 1.0':
        return 'onGenerateRoute: Navigator1Router.generateRoute, initialRoute: \'/\',';
      case 'Navigator 2.0':
        return 'routerDelegate: _routerDelegate, routeInformationParser: _routeInformationParser,';
      case 'GoRouter':
        return 'routerConfig: router,';
      case 'AutoRoute':
        return 'routerDelegate: _appRouter.delegate(), routeInformationParser: _appRouter.defaultRouteParser(),';
      default:
        return 'home: Scaffold(appBar: AppBar(title: Text("Unknown Routing Style")), body: Center(child: Text("Unknown routing style selected"))),';
    }
  }

  // Helper function to get router setup
  String _getRouterSetup(String routingStyle) {
    switch (routingStyle) {
      case 'Navigator 2.0':
        return 'final _routerDelegate = Navigator2Router(); final _routeInformationParser = Navigator2Parser();';
      case 'AutoRoute':
        return 'final _appRouter = AppRouter();';
      default:
        return '';
    }
  }
}
