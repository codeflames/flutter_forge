import 'dart:io';

class WidgetTestEditor {
  void updateWidgetTest(String appName) {
    final testFilePath = '$appName/test/widget_test.dart';
    final testFile = File(testFilePath);

    if (!testFile.existsSync()) {
      print("Error: $testFilePath does not exist.");
      return;
    }

    // New test content to be added to widget_test.dart
    final newTests = '''
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:$appName/main.dart';

void main() {
  testWidgets('App loads and displays HomePage', (WidgetTester tester) async {
    // Initialize the app and trigger a frame
    await tester.pumpWidget(MyApp());

    // Check that HomePage is loaded by verifying a widget with the title text
    expect(find.text('Home Page'), findsOneWidget);
  });

  testWidgets('Navigate to Details Page and back', (WidgetTester tester) async {
    // Initialize the app and trigger a frame
    await tester.pumpWidget(MyApp());

    // Verify that Home Page is initially displayed
    expect(find.text('Home Page'), findsOneWidget);
    expect(find.text('Details Page'), findsNothing);

    // Find and tap on the navigation button to go to Details Page
    await tester.tap(find.byIcon(Icons.navigate_next));  // Assuming you have a navigation button/icon
    await tester.pumpAndSettle(); // Wait for animations to complete

    // Verify that the Details Page is displayed
    expect(find.text('Details Page'), findsOneWidget);
    expect(find.text('Home Page'), findsNothing);

    // Navigate back to Home Page
    await tester.tap(find.byIcon(Icons.arrow_back));  // Assuming you have a back button
    await tester.pumpAndSettle();

    // Verify that Home Page is displayed again
    expect(find.text('Home Page'), findsOneWidget);
  });
}
''';

    // Write the updated content to the file
    testFile.writeAsStringSync(newTests, mode: FileMode.write);
    print("widget_test.dart file updated with new tests.");
  }
}
