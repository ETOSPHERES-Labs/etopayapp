import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:eto_pay/screens/pin_setup_screen.dart';

void main() {
  testWidgets('PinSetupScreen renders and shows pin fields',
      (WidgetTester tester) async {
    await tester.pumpWidget(
        const MaterialApp(home: PinSetupScreen(network: 'EVM-based')));
    expect(find.text('Set up your PIN'), findsOneWidget);
    expect(find.text('Enter PIN'), findsOneWidget);
    expect(find.text('Confirm PIN'), findsOneWidget);
  });
}
