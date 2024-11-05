import 'dart:io';

class ProjectCreator {
  Future<void> confirmCreation(String? appName, String? appId) async {
    if (_shouldCreateProject()) {
      await _createFlutterProject(appName!, appId!);
    } else {
      _exitProcess();
    }
  }

  bool _shouldCreateProject() {
    stdout.write("\nDo you want to create the Flutter project now? (y/n): ");
    String? response = stdin.readLineSync();
    return response?.toLowerCase() == 'y' || response?.toLowerCase() == 'yes';
  }

  void _exitProcess() {
    print("Exiting...");
    exit(0);
  }

  Future<void> _createFlutterProject(String appName, String appId) async {
    print("\nCreating Flutter project...");
    var result =
        await Process.run('flutter', ['create', '--org', appId, appName]);
    _handleProcessResult(result, appName, appId);
  }

  void _handleProcessResult(
      ProcessResult result, String appName, String appId) {
    if (result.exitCode == 0) {
      print(
          "Flutter project '$appName' created successfully with app ID '$appId'!");
    } else {
      print("Error creating Flutter project: ${result.stderr}");
    }
  }
}
