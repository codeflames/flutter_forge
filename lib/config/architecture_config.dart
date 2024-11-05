import 'dart:io';

import 'package:flutter_forge/utils/file_utils.dart';

class ArchitectureConfig {
  void setupArchitecture(String appName, String architecture,
      String routingStyle, String featureName) {
    final baseDir = '$appName/lib/app/features/$featureName';

    try {
      if (architecture == 'Clean') {
        Directory('$baseDir/domain/entities').createSync(recursive: true);
        Directory('$baseDir/domain/usecases').createSync(recursive: true);
        Directory('$baseDir/domain/interfaces').createSync(recursive: true);
        Directory('$baseDir/data/repositories').createSync(recursive: true);
        Directory('$baseDir/data/data_sources').createSync(recursive: true);
        Directory('$baseDir/presentation/providers')
            .createSync(recursive: true);
        Directory('$baseDir/presentation/views').createSync(recursive: true);
        Directory('$baseDir/presentation/widgets').createSync(recursive: true);
        Directory('$baseDir/infrastructure/services')
            .createSync(recursive: true);
        print("Clean architecture folders created.");
      } else if (architecture == 'MVVM') {
        Directory('$baseDir/view').createSync(recursive: true);
        Directory('$baseDir/viewmodel').createSync(recursive: true);
        Directory('$baseDir/model').createSync(recursive: true);
        Directory('$baseDir/repository').createSync(recursive: true);
        Directory('$baseDir/services').createSync(recursive: true);
        print("MVVM architecture folders created.");
      } else if (architecture == 'MVC') {
        Directory('$baseDir/view').createSync(recursive: true);
        Directory('$baseDir/controller').createSync(recursive: true);
        Directory('$baseDir/model').createSync(recursive: true);
        Directory('$baseDir/services').createSync(recursive: true);
        print("MVC architecture folders created.");
      } else {
        print("Unknown architecture type.");
      }

      // Create initial pages based on routing style and architecture
      _createPages(appName, architecture, routingStyle, baseDir);
    } catch (e) {
      print("Error setting up architecture: $e");
    }
  }

  void _createPages(String appName, String architecture, String routingStyle,
      String baseDir) {
    // Set directory based on architecture type
    final pageDir = architecture == 'Clean'
        ? '$baseDir/presentation/views'
        : '$baseDir/view';

    // Create basic pages for the app
    _createPageFile(appName, pageDir, 'home_page', routingStyle,
        isHomePage: true);
    _createPageFile(appName, pageDir, 'details_page', routingStyle);
    print("Basic pages created in $pageDir");
  }

  void _createPageFile(
      String appName, String dir, String pageName, String routingStyle,
      {bool isHomePage = false}) {
    // Add annotation if routingStyle is AutoRoute
    final routerAnnotation = routingStyle == 'AutoRoute' ? '@RoutePage()' : '';
    // final importAutoRoute = routingStyle == 'AutoRoute'
    //     ? "import 'package:auto_route/auto_route.dart'; \n ${isHomePage ? "import 'package:$appName/core/routing/app_router.gr.dart'" : ""};"
    //     : '';
    final importAutoRoute = routingStyle == 'AutoRoute'
        ? "import 'package:auto_route/auto_route.dart';"
        : '';
    final extraImportAutoRoute =
        "import 'package:$appName/core/routing/app_router.gr.dart';";

    final importGoRouter = routingStyle == 'GoRouter'
        ? "import 'package:go_router/go_router.dart';"
        : '';

    // Add navigation code for different routing styles
    final navigateToDetailsPage = routingStyle == 'AutoRoute'
        ? "context.router.push(const DetailsRoute());"
        : routingStyle == 'GoRouter'
            ? "context.go('/details');"
            : "Navigator.push(context, MaterialPageRoute(builder: (context) => ${toScreenName('details_page')}()));";

    final pageFile = File('$dir/$pageName.dart');
    pageFile.writeAsStringSync('''
import 'package:flutter/material.dart';
$importAutoRoute
$importGoRouter
${isHomePage && routingStyle == 'AutoRoute' ? extraImportAutoRoute : ''}

$routerAnnotation
class ${toScreenName(pageName)} extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("${pageName.replaceAll('_', ' ').capitalize()}")),
      body: Center(
        child: ${isHomePage ? '''
          ElevatedButton(
            onPressed: () {
              $navigateToDetailsPage
            },
            child: Text("View Page"),
          )
        ''' : '''
          Text("${pageName.capitalize()} Page")
        '''}
      ),
    );
  }
}
''');
  }

  String toScreenName(String pageName) {
    return pageName
        .toLowerCase()
        .replaceAll(RegExp(r'[_-]'), ' ')
        .split(' ')
        .map((word) => word[0].toUpperCase() + word.substring(1))
        .join('');
  }
}
