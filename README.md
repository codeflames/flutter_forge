# Flutter Forge

Flutter Forge is a command-line tool designed to simplify the initial setup of Flutter projects by providing a dynamic template generator. It allows developers to create customizable project templates, supporting various architectures, state management solutions, themes, and routing configurations. By automating the setup process, Flutter Forge enhances productivity and ensures consistent project structures.

## Table of Contents
- [Installation](#installation)
- [Usage](#usage)
- [Folder Structure](#folder-structure)
- [Contributing](#contributing)
- [License](#license)

## Installation

To install Flutter Forge globally on your machine, use the following command:

```bash
dart pub global activate --source git https://github.com/codeflames/flutter_forge.git
```

### PATH Configuration (if necessary)
Ensure that the Dart SDK's pub-cache bin directory is in your system's PATH. This allows you to run globally activated packages from the terminal.

- For macOS/Linux:
```bash
export PATH="$PATH":"$HOME/.pub-cache/bin"
```
-For Windows: Add the path C:\Users\<YourUsername>\.pub-cache\bin to your system PATH environment variable.

## Usage
Once installed, you can use Flutter Forge to create a new Flutter project with customizable templates. Here’s how to run the CLI:

```
flutter_forge
```

You can specify different options and configurations based on your project needs. For help, you can run:
```
flutter_forge --help
```

## Folder Structure
Here's a brief overview of the folder structure for the Flutter Forge project:

```
📦flutter_forge
 ┣ 📂bin
 ┃ ┗ 📜flutter_forge.dart
 ┣ 📂lib
 ┃ ┣ 📂config
 ┃ ┃ ┣ 📜architecture_config.dart
 ┃ ┃ ┣ 📜dependency_manager.dart
 ┃ ┃ ┣ 📜routing_config.dart
 ┃ ┃ ┣ 📜state_management_config.dart
 ┃ ┃ ┗ 📜theme_config.dart
 ┃ ┣ 📂input
 ┃ ┃ ┗ 📜user_input.dart
 ┃ ┣ 📂project
 ┃ ┃ ┗ 📜project_creator.dart
 ┃ ┣ 📂utils
 ┃ ┃ ┣ 📜file_utils.dart
 ┃ ┃ ┣ 📜main_page_editor.dart
 ┃ ┃ ┗ 📜test_file_editor.dart
 ┃ ┗ 📜flutterforge.dart
 ┣ 📜.gitignore
 ┣ 📜CHANGELOG.md
 ┣ 📜README.md
 ┣ 📜analysis_options.yaml
 ┣ 📜pubspec.lock
 ┗ 📜pubspec.yaml
 ```

## Description of Key Files
- bin/flutter_forge.dart: The main entry point of the CLI application where the command-line logic resides.
- lib/: Contains any additional library files needed for the functionality of the CLI.
- pubspec.yaml: Defines the project metadata and dependencies.
- README.md: Provides documentation and instructions for the project.


## Contributing
Contributions are welcome! If you would like to contribute to Flutter Forge, please follow these steps:

Fork the repository.
Create a new branch ```git checkout -b feature/YourFeature```.

Make your changes and commit them ```git commit -m 'Add some feature'```.

Push to the branch ```git push origin feature/YourFeature```.

Open a pull request.



## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.