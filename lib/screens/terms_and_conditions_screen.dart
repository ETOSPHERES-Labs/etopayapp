import 'package:flutter/material.dart';
import 'package:eto_pay/widgets/onboarding.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TermsAndConditionsScreen extends StatefulWidget {
  const TermsAndConditionsScreen({super.key});

  @override
  State<TermsAndConditionsScreen> createState() =>
      _TermsAndConditionsScreenState();
}

class _TermsAndConditionsScreenState extends State<TermsAndConditionsScreen> {
  bool _accepted = false;

  Future<void> _onContinue() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('terms_accepted', true);
    if (!mounted) return;
    context.go('/choose-network');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Terms and Conditions')),
      body: ImageCardListWidget(
        svgAssetPath: 'assets/images/onboarding_bg_1.svg',
        textData: 'Welcome to ETOPay',
        subtitle: 'Please accept the terms and conditions to continue.',
        showCheckbox: true,
        isChecked: _accepted,
        onCheckboxChanged: (v) => setState(() => _accepted = v ?? false),
        checkboxLabel: 'I accept the Terms and Conditions',
        footer: Padding(
          padding: const EdgeInsets.only(top: 24.0),
          child: ElevatedButton(
            onPressed: _accepted ? _onContinue : null,
            child: const Text('Continue'),
          ),
        ),
      ),
    );
  }
}
