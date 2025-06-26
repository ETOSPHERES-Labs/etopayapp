import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:eto_pay/screens/password_setup_screen.dart';

void main() {
  testWidgets('PasswordSetupScreen renders and shows password fields',
      (WidgetTester tester) async {
    await tester.pumpWidget(
        const MaterialApp(home: PasswordSetupScreen(network: 'EVM-based')));
    expect(find.text('Create your new password'), findsOneWidget);
    expect(find.text('Enter password'), findsOneWidget);
    expect(find.text('Confirm password'), findsOneWidget);
  });
}
