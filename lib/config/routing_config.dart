import 'dart:io';

class RoutingConfig {
  void setupRouting(String appName, String routingStyle, String architecture,
      String stateManagement) {
    // Create the routing directory
    final routingDir = '$appName/lib/core/routing';
    if (!Directory(routingDir).existsSync()) {
      Directory(routingDir).createSync(recursive: true);
      print("lib/core/routing directory created.");
    }

    // Create router file with the selected routing style
    final routerFilePath = '$routingDir/app_router.dart';
    final routerFile = File(routerFilePath);
    String routingCode = _getRoutingCode(appName, routingStyle, architecture);
    routerFile.writeAsStringSync(routingCode);
    print("Router file created for $routingStyle at: $routerFilePath");
  }

  String _getRoutingCode(
      String appName, String routingStyle, String architecture) {
    // Determine the base import path based on architecture
    String importPath;
    switch (architecture) {
      case 'MVC':
      case 'MVVM':
        // importPath = 'package:$appName/app/views';
        importPath = 'package:$appName/app/features/home/view';
        break;
      case 'Clean':
        // importPath = 'package:$appName/app/presentation';
        importPath = 'package:$appName/app/features/home/presentation';
        break;
      default:
        throw Exception("Unsupported architecture: $architecture");
    }

    switch (routingStyle) {
      case 'Navigator 1.0':
        return '''
import 'package:flutter/material.dart';
import '$importPath/home_page.dart';
import '$importPath/details_page.dart';


class Navigator1Router {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => HomePage());
      case '/details':
        return MaterialPageRoute(builder: (_) => DetailsPage());
      default:
        return MaterialPageRoute(builder: (_) => HomePage());
    }
  }
}
''';

      case 'Navigator 2.0':
        return '''
import 'package:flutter/material.dart';

class Navigator2Router extends RouterDelegate with ChangeNotifier {
  // Navigator 2.0 setup code here
}

class Navigator2Parser extends RouteInformationParser {
  // Route information parser setup
}
''';

      case 'GoRouter':
        return '''
import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';
import '$importPath/home_page.dart';
import '$importPath/details_page.dart';

final GoRouter router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => HomePage(),
    ),
    GoRoute(
      path: '/details',
      builder: (context, state) => DetailsPage(),
    ),
  ],
);
''';

      case 'AutoRoute':
        return '''
import 'package:auto_route/auto_route.dart';
import 'package:$appName/core/routing/app_router.gr.dart';

@AutoRouterConfig(
  replaceInRouteName: 'Page,Route',
)
class AppRouter extends \$AppRouter{
  @override
  List<AutoRoute> get routes => [
        AutoRoute(page: HomeRoute.page, initial: true),
        AutoRoute(page: DetailsRoute.page),
      ];
}
''';

      default:
        throw Exception("Unsupported routing style: $routingStyle");
    }
  }
}
