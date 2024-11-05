import 'dart:io';

String capitalizeString(String str) {
  // check if the string is empty
  if (str.isEmpty) {
    return '';
  }
  return '${str[0].toUpperCase()}${str.substring(1)}';
}

extension StringExtension on String {
  String capitalize() => capitalizeString(this);
}

void runPubGetAndBuildRunner(String appName, bool runBuildRunner) {
  // Ensure dependencies are properly installed
  print("Running flutter pub get...");
  final pubGetResult = Process.runSync(
    'flutter',
    ['pub', 'get'],
    workingDirectory: appName,
  );

  if (pubGetResult.exitCode != 0) {
    print("Failed to get dependencies: ${pubGetResult.stderr}");
    return;
  }

  print("Dependencies installed successfully.");

  if (runBuildRunner) {
    // Now, run the build_runner
    print("Running build_runner...");
    final buildResult = Process.runSync(
      'dart',
      ['run', 'build_runner', 'build', '--delete-conflicting-outputs'],
      workingDirectory: appName,
    );

    if (buildResult.exitCode == 0) {
      print("Build runner completed successfully.");
    } else {
      print("Build runner failed: ${buildResult.stderr}");
    }
  }
}
