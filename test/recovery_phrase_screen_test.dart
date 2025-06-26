import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:eto_pay/screens/recovery_phrase_screen.dart';

void main() {
  testWidgets('RecoveryPhraseScreen renders and shows reveal button',
      (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: RecoveryPhraseScreen()));
    expect(find.text('Recovery phrase'), findsOneWidget);
    expect(find.text('Reveal recovery phrase'), findsOneWidget);
  });
}
