import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:eto_pay/screens/choose_network_screen.dart';

void main() {
  testWidgets('ChooseNetworkScreen renders and shows network cards',
      (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: ChooseNetworkScreen()));
    expect(find.text('Choose Network'), findsOneWidget);
    expect(find.text('EVM-based'), findsOneWidget);
    expect(find.text('IOTA'), findsOneWidget);
    expect(find.text('ERC20-based'), findsOneWidget);
    expect(find.byType(TextButton), findsWidgets);
  });
}
