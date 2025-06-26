import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:eto_pay/screens/recovery_phrase_verification_screen.dart';

void main() {
  testWidgets('RecoveryPhraseVerificationScreen renders and shows Next button',
      (WidgetTester tester) async {
    final phrase = List.generate(24, (i) => 'word${i + 1}');
    await tester.pumpWidget(MaterialApp(
        home: RecoveryPhraseVerificationScreen(recoveryPhrase: phrase)));
    expect(find.text('Verify recovery phrase'), findsOneWidget);
    expect(find.text('Next'), findsOneWidget);
  });
}
