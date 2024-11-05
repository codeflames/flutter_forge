import 'package:flutter_forge/config/architecture_config.dart';
import 'package:flutter_forge/config/dependency_manager.dart';
import 'package:flutter_forge/config/state_management_config.dart';
import 'package:flutter_forge/utils/file_utils.dart';
import 'package:flutter_forge/utils/main_page_editor.dart';
import 'package:flutter_forge/config/routing_config.dart';
import 'package:flutter_forge/config/theme_config.dart';
import 'package:flutter_forge/utils/test_file_editor.dart';

import 'input/user_input.dart';
import 'project/project_creator.dart';

class FlutterForge {
  Future<void> initializeApp() async {
    UserInput input = UserInput();
    ProjectCreator creator = ProjectCreator();
    ArchitectureConfig architectureConfig = ArchitectureConfig();
    ThemeConfig themeConfig = ThemeConfig();
    RoutingConfig routingConfig = RoutingConfig();
    MainPageEditor mainPageEditor = MainPageEditor();
    WidgetTestEditor widgetTestEditor = WidgetTestEditor();
    StateManagementConfig stateManagementConfig = StateManagementConfig();
    DependencyManager dependencyManager = DependencyManager();

    String appName = input.getAppName() ?? 'app';
    String appId = input.getAppId() ?? 'com.example.app';
    String architecture = input.chooseArchitecture() ?? 'MVC';
    String stateManagement = input.chooseStateManagement() ?? 'Provider';
    String themeStyle = input.chooseThemeStyle() ?? 'Light';
    Map<String, String?> themeColors = input.getThemeColors();
    String routing = input.chooseRouting() ?? 'Navigator';

    input.summarizeSelections(
      appName: appName,
      appId: appId,
      architecture: architecture,
      stateManagement: stateManagement,
      themeStyle: themeStyle,
      themeColors: themeColors,
      routing: routing,
    );

    await creator.confirmCreation(appName, appId);

    dependencyManager.addDependencies(
        appName: appName,
        stateManagement: stateManagement,
        routingStyle: routing);

    themeConfig.createThemeFile(
        appName,
        themeStyle,
        themeColors['primaryColor'],
        themeColors['accentColor'],
        themeColors['textColor']);

    routingConfig.setupRouting(appName, routing, architecture, stateManagement);
    architectureConfig.setupArchitecture(
        appName, architecture, routing, 'home');

    Future.delayed(const Duration(seconds: 2), () {
      if (routing == 'AutoRoute') {
        runPubGetAndBuildRunner(appName, true);
      } else {
        runPubGetAndBuildRunner(appName, false);
      }
    });

    stateManagementConfig.setupStateManagement(
        appName: appName,
        architecture: architecture,
        stateManagement: stateManagement);

    mainPageEditor.createMainPage(
        appName, routing, architecture, stateManagement, themeStyle);

    widgetTestEditor.updateWidgetTest(appName);
  }
}
