import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:netbrains/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('App loads and displays content', (WidgetTester tester) async {
    // launch app
    app.main();
    await tester.pumpAndSettle();

    // checking text is visible or not
    expect(find.text('З А М Е Т К И'), findsOneWidget);

    // press the button
    await tester.tap(find.byIcon(Icons.add));
    await tester.pumpAndSettle();

    // checking textField is visible or not
    expect(find.byType(TextFormField), findsOneWidget);
  });
}
