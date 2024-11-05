// import 'package:args/args.dart';

// const String version = '0.0.1';

// ArgParser buildParser() {
//   return ArgParser()
//     ..addFlag(
//       'help',
//       abbr: 'h',
//       negatable: false,
//       help: 'Print this usage information.',
//     )
//     ..addFlag(
//       'verbose',
//       abbr: 'v',
//       negatable: false,
//       help: 'Show additional command output.',
//     )
//     ..addFlag(
//       'version',
//       negatable: false,
//       help: 'Print the tool version.',
//     );
// }

// void printUsage(ArgParser argParser) {
//   print('Usage: dart flutter_forge.dart <flags> [arguments]');
//   print(argParser.usage);
// }

// void main(List<String> arguments) {
//   final ArgParser argParser = buildParser();
//   try {
//     final ArgResults results = argParser.parse(arguments);
//     bool verbose = false;

//     // Process the parsed arguments.
//     if (results.wasParsed('help')) {
//       printUsage(argParser);
//       return;
//     }
//     if (results.wasParsed('version')) {
//       print('flutter_forge version: $version');
//       return;
//     }
//     if (results.wasParsed('verbose')) {
//       verbose = true;
//     }

//     // Act on the arguments provided.
//     print('Positional arguments: ${results.rest}');
//     if (verbose) {
//       print('[VERBOSE] All arguments: ${results.arguments}');
//     }
//   } on FormatException catch (e) {
//     // Print usage information if an invalid argument was provided.
//     print(e.message);
//     print('');
//     printUsage(argParser);
//   }
// }

import 'package:args/args.dart';
import 'package:flutter_forge/flutterforge.dart';

const String version = '0.0.1';

void main(List<String> arguments) {
  final ArgParser argParser = buildParser();
  final ArgResults results = parseArguments(argParser, arguments);

  // Handle parsed flags and commands
  if (results['help'] == true) {
    printUsage(argParser);
    return;
  }

  if (results['version'] == true) {
    print('FlutterForge CLI version: $version');
    return;
  }

  final bool verbose = results['verbose'] == true;
  print("Starting FlutterForge setup...");
  if (verbose) {
    print("[VERBOSE] Initializing app configuration.");
  }

  final flutterForge = FlutterForge();
  flutterForge.initializeApp().then((_) {
    print("FlutterForge setup completed.");
  }).catchError((error) {
    print("Error: $error");
  });
}

/// Builds and returns the ArgParser for CLI argument handling.
ArgParser buildParser() {
  return ArgParser()
    ..addFlag(
      'help',
      abbr: 'h',
      negatable: false,
      help: 'Show this usage information.',
    )
    ..addFlag(
      'version',
      abbr: 'v',
      negatable: false,
      help: 'Display the version of FlutterForge CLI.',
    )
    ..addFlag(
      'verbose',
      // abbr: 'v',
      negatable: false,
      help: 'Enable verbose output for debugging.',
    );
}

/// Parses and handles CLI arguments.
ArgResults parseArguments(ArgParser argParser, List<String> arguments) {
  try {
    return argParser.parse(arguments);
  } catch (e) {
    print("Error parsing arguments: $e");
    printUsage(argParser);
    throw Exception("Argument parsing failed.");
  }
}

/// Prints usage information for the CLI.
void printUsage(ArgParser argParser) {
  print('FlutterForge CLI');
  print('Usage: dart flutter_forge.dart <options>');
  print(argParser.usage);
}
