import 'dart:io';

class UserInput {
  String? getAppName() {
    stdout.write("Enter the name of your app: ");
    return stdin.readLineSync();
  }

  String? getAppId() {
    stdout.write("Enter preferred app ID (e.g., com.example.app): ");
    return stdin.readLineSync();
  }

  String? chooseArchitecture() {
    print("\nChoose architecture:");
    const architectures = ["MVC", "MVVM", "Clean"];
    return _chooseOption(architectures);
  }

  String? chooseStateManagement() {
    print("\nChoose state management solution:");
    const stateManagementOptions = ["Provider", "Riverpod", "Bloc", "GetX"];
    return _chooseOption(stateManagementOptions);
  }

  String? chooseThemeStyle() {
    print("\nChoose theme style:");
    const themeStyles = ["Light", "Dark", "Custom"];
    return _chooseOption(themeStyles);
  }

  Map<String, String?> getThemeColors() {
    print(
        "\n(Optional) Enter theme colors in hexadecimal (e.g., #ff5722). Press Enter to skip any of them.");
    return {
      'primaryColor': _getColorInput("Primary color: "),
      'accentColor': _getColorInput("Accent color: "),
      'textColor': _getColorInput("Text color: "),
    };
  }

  String? chooseRouting() {
    print("\nChoose routing configuration:");
    const routingOptions = [
      "Navigator 1.0",
      "Navigator 2.0",
      "GoRouter",
      "AutoRoute"
    ];
    return _chooseOption(routingOptions);
  }

  void summarizeSelections({
    String? appName,
    String? appId,
    String? architecture,
    String? stateManagement,
    String? themeStyle,
    Map<String, String?>? themeColors,
    String? routing,
  }) {
    print("\nConfiguring your app with the following options:");
    print("App Name: $appName");
    print("App ID: $appId");
    print("Architecture: $architecture");
    print("State Management: $stateManagement");
    print("Theme Style: $themeStyle");
    if (themeColors != null) {
      if (themeColors['primaryColor'] != null) {
        print("Primary Color: ${themeColors['primaryColor']}");
      }
      if (themeColors['accentColor'] != null) {
        print("Accent Color: ${themeColors['accentColor']}");
      }
      if (themeColors['textColor'] != null) {
        print("Text Color: ${themeColors['textColor']}");
      }
    }
    print("Routing: $routing");
  }

  int _getChoice(int max) {
    int? choice;
    do {
      stdout.write("Enter your choice (1-$max): ");
      choice = int.tryParse(stdin.readLineSync() ?? '');
    } while (choice == null || choice < 1 || choice > max);
    return choice;
  }

  String? _chooseOption(List<String> options) {
    for (int i = 0; i < options.length; i++) {
      print("${i + 1}. ${options[i]}");
    }
    int choice = _getChoice(options.length);
    return options[choice - 1];
  }

  String? _getColorInput(String prompt) {
    stdout.write(prompt);
    String? color = stdin.readLineSync();
    return color!.isNotEmpty ? color : null;
  }
}
