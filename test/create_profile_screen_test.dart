import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:eto_pay/screens/create_profile_screen.dart';

void main() {
  testWidgets('CreateProfileScreen renders and shows software profile card',
      (WidgetTester tester) async {
    await tester.pumpWidget(
        const MaterialApp(home: CreateProfileScreen(network: 'EVM-based')));
    expect(find.text('EVM-based'), findsOneWidget);
    expect(find.text('Create a software profile'), findsOneWidget);
  });
}
