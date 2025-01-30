import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:developer_test_project/screens/home_screen.dart';

void main() {
  testWidgets('HomeScreen should have 4 buttons and View Logs button', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: HomeScreen()));

    // Check for 4 buttons
    for (int i = 1; i <= 4; i++) {
      expect(find.text('Button $i'), findsOneWidget);
    }

    // Check for View Logs button
    expect(find.text('View Logs'), findsOneWidget);
  });

  testWidgets('Clicking a button shows Snackbar', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: HomeScreen()));

    await tester.tap(find.text('Button 1'));
    await tester.pump();

    expect(find.text('Button 1 pressed'), findsOneWidget);
  });
}
