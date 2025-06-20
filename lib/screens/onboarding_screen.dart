import 'package:eto_pay/core/logger.dart';
import 'package:flutter/material.dart';
import 'package:eto_pay/widgets/onboarding.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  bool isChecked = false;

  void handleCheckboxChanged(bool? value) {
    setState(() {
      isChecked = value ?? false;
    });

    // Optional: Do something when checked
    if (isChecked) {
      AppLogger.i('✅ User accepted the terms');
    } else {
      AppLogger.i('❌ User unchecked the box');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ImageCardListWidget(
        svgAssetPath: 'assets/images/onboarding_bg_1.svg',
        textData:
            'Send, receive and take control of your cryptocurrency tokens',
        showCheckbox: true,
        isChecked: isChecked,
        onCheckboxChanged: handleCheckboxChanged,
        checkboxLabel: 'I accept the Terms of Service and Privacy Policy',
      ),
    );
  }
}
