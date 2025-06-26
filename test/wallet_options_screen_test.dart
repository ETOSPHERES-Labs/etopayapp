import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:eto_pay/screens/wallet_options_screen.dart';

void main() {
  testWidgets('WalletOptionsScreen renders and shows wallet option cards',
      (WidgetTester tester) async {
    await tester.pumpWidget(
        const MaterialApp(home: WalletOptionsScreen(network: 'EVM-based')));
    expect(find.text('EVM-based'), findsOneWidget);
    expect(find.text('Create new wallet'), findsOneWidget);
    expect(find.text('Import an existing wallet'), findsOneWidget);
  });
}
