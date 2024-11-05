import 'dart:io';

class StateManagementConfig {
  void setupStateManagement(
      {required String appName,
      required String architecture,
      required String stateManagement}) async {
    final baseDir = '$appName/lib/app/features/home';

    try {
      _createStateManagementDirs(
          baseDir, architecture, stateManagement, appName);
      print("State management setup completed.");
    } catch (e) {
      print("Error setting up state management: $e");
    }
  }

  void _createStateManagementDirs(String baseDir, String architecture,
      String stateManagement, String appName) {
    String managementDir;

    switch (architecture) {
      case 'Clean':
        managementDir = '$baseDir/presentation/providers';
        break;
      case 'MVVM':
        managementDir = '$baseDir/viewmodel';
        break;
      case 'MVC':
        managementDir = '$baseDir/controller';
        break;
      default:
        print("Unknown architecture type.");
        return;
    }

    if (!Directory(managementDir).existsSync()) {
      Directory(managementDir).createSync(recursive: true);
    }

    String controllerFileName;
    switch (stateManagement) {
      case 'Riverpod':
      case 'Provider':
        controllerFileName = 'login_provider.dart';
        break;
      case 'Bloc':
        controllerFileName = 'login_bloc.dart';
        break;
      case 'GetX':
        controllerFileName = 'login_controller.dart';
        break;
      default:
        print("Unknown state management type.");
        return;
    }

    _createStateManagementFile(managementDir, controllerFileName,
        stateManagement, architecture, appName);
    _createLoginStateFile(managementDir, stateManagement);
    _createLoginRepositoryFile(baseDir);
  }

  void _createStateManagementFile(String dir, String fileName,
      String stateManagement, String architecture, String appName) {
    final filePath = '$dir/$fileName';

    String fileContent = '';

    if (stateManagement == 'Riverpod') {
      fileContent = '''
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:$appName/app/features/home/repository/login_repository_impl.dart';
import 'login_state.dart';

final loginProvider = StateNotifierProvider<LoginController, LoginState>((ref) {
  return LoginController();
});

class LoginController extends StateNotifier<LoginState> {
  final _loginRepository = LoginRepositoryImpl();

  LoginController() : super(LoginState.loggedOut());

  void login(String email, String password) async {
    state = LoginState.loggingIn();
    final user = await _loginRepository.login(email, password);
    state = LoginState.loggedIn(user);
  }
}
''';
    } else if (stateManagement == 'Provider') {
      fileContent = '''
import 'package:flutter/material.dart';
import 'package:$appName/app/features/home/repository/login_repository_impl.dart';
import 'login_state.dart';

class LoginController with ChangeNotifier {
  final _loginRepository = LoginRepositoryImpl();
  LoginState _state = LoginState.loggedOut();

  LoginState get state => _state;

  void login(String email, String password) async {
    _state = LoginState.loggingIn();
    notifyListeners();
    final user = await _loginRepository.login(email, password);
    _state = LoginState.loggedIn(user);
    notifyListeners();
  }
}
''';
    } else if (stateManagement == 'GetX') {
      fileContent = '''
import 'package:get/get.dart';
import 'package:$appName/app/features/home/repository/login_repository_impl.dart';
import 'login_state.dart';

class LoginController extends GetxController {
  final _loginRepository = LoginRepositoryImpl();
  var state = LoginState.loggedOut.obs;

  void login(String email, String password) async {
    state.value = LoginState.loggingIn();
    final user = await _loginRepository.login(email, password);
    state.value = LoginState.loggedIn(user);
  }
}
''';
    } else if (stateManagement == 'Bloc') {
      fileContent = '''
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:$appName/app/features/home/repository/login_repository_impl.dart';

import 'login_state.dart';
part 'login_event.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final _loginRepository = LoginRepositoryImpl();

  LoginBloc() : super(LoginState.loggedOut()) {
    on<LoginEvent>((event, emit) async {
      if (event is LoginRequested) {
        emit(LoginState.loggingIn());
        final user = await _loginRepository.login(event.email, event.password);
        emit(LoginState.loggedIn(user));
      }
    });
  }
}
''';

      // Create additional files for `LoginEvent` and `LoginState`
      _createBlocLoginEventFile(dir);
    }

    File(filePath).writeAsStringSync(fileContent);
    print("$fileName created at $dir.");
  }

  void _createBlocLoginEventFile(String dir) {
    final eventFilePath = '$dir/login_event.dart';
    final eventContent = '''
part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoginRequested extends LoginEvent {
  final String email;
  final String password;

  LoginRequested(this.email, this.password);

  @override
  List<Object?> get props => [email, password];
}
''';
    File(eventFilePath).writeAsStringSync(eventContent);
    print("LoginEvent file created at $dir.");
  }

  void _createLoginStateFile(String dir, String stateManagement) {
    final stateFilePath = '$dir/login_state.dart';

    String stateContent = '''
class LoginState {
  final bool isLoading;
  final bool isLoggedIn;
  final String? user;

  LoginState._({this.isLoading = false, this.isLoggedIn = false, this.user});

  factory LoginState.loggedOut() => LoginState._();
  factory LoginState.loggingIn() => LoginState._(isLoading: true);
  factory LoginState.loggedIn(String user) => LoginState._(isLoggedIn: true, user: user);
}
''';

    File(stateFilePath).writeAsStringSync(stateContent);
    print("LoginState file created at $dir.");
  }

  void _createLoginRepositoryFile(String baseDir) {
    final repositoryDir = '$baseDir/repository';
    if (!Directory(repositoryDir).existsSync()) {
      Directory(repositoryDir).createSync(recursive: true);
    }

    final filePath = '$repositoryDir/login_repository_impl.dart';

    final repositoryContent = '''
class LoginRepositoryImpl {
  Future<String> login(String email, String password) async {
    // Simulate a login process (replace with actual API call logic)
    await Future.delayed(Duration(seconds: 2));
    return "user_id_123";  // Replace with actual user ID or data from server
  }
}
''';

    File(filePath).writeAsStringSync(repositoryContent);
    print("LoginRepositoryImpl file created at $repositoryDir.");
  }
}
