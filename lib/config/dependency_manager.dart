import 'dart:developer';
import 'dart:io';

class DependencyManager {
  DependencyManager();

  void addDependencies(
      {required String appName,
      required String routingStyle,
      required String stateManagement}) {
    _addRoutingDependencies(routingStyle, appName);
    _addStateManagementDependencies(stateManagement, appName);
  }

  void _addRoutingDependencies(
    String routingStyle,
    String appName,
  ) {
    String dependencies = '';
    String devDependencies = '';

    // Define the dependencies based on the selected routing style
    switch (routingStyle) {
      case 'GoRouter':
        dependencies = 'go_router: ^6.0.0';
        break;
      case 'AutoRoute':
        dependencies = 'auto_route: ^6.0.0\n  auto_route_generator: ^6.0.0';
        devDependencies = 'build_runner: ^2.0.0';
        break;
      default:
        print("Unknown routing style.");
        return;
    }

    _updatePubspec(dependencies, devDependencies, appName);
  }

  void _addStateManagementDependencies(String stateManagement, appName) {
    String dependencies;

    log('State management: $stateManagement');

    // Define the dependencies based on the selected state management solution
    switch (stateManagement) {
      case 'Riverpod':
        dependencies = 'flutter_riverpod: ^2.0.0';
        break;
      case 'Provider':
        dependencies = 'provider: ^6.0.0';
        break;
      case 'Bloc':
        dependencies = 'flutter_bloc: ^8.0.0\n  equatable: ^2.0.0';
        break;
      case 'GetX':
        dependencies = 'get: ^4.6.5';
        break;
      default:
        print(
            "Dependency manager: Unknown state management type. $stateManagement");
        return;
    }

    _updatePubspec(dependencies, '', appName);
  }

  void _updatePubspec(String dependencies, String devDependencies, appName) {
    final pubspecPath = '$appName/pubspec.yaml';
    final pubspecFile = File(pubspecPath);

    if (!pubspecFile.existsSync()) {
      throw Exception("pubspec.yaml not found at $pubspecPath");
    }

    final pubspecContent = pubspecFile.readAsStringSync();

    // Check if dependencies already exist in pubspec.yaml to avoid duplicates
    if (pubspecContent.contains(dependencies)) {
      print("Dependencies already added to pubspec.yaml");
      return;
    }

    // Update pubspec.yaml with dependencies
    if (dependencies.isNotEmpty) {
      pubspecFile.writeAsStringSync(
        pubspecContent.replaceFirst(
          'dependencies:',
          'dependencies:\n  $dependencies',
        ),
      );
    }

    if (devDependencies.isNotEmpty) {
      pubspecFile.writeAsStringSync(
        pubspecFile.readAsStringSync().replaceFirst(
              'dev_dependencies:',
              'dev_dependencies:\n  $devDependencies',
            ),
      );
    }

    print("Added dependencies to pubspec.yaml");
  }
}
