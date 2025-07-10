import 'package:eto_pay/widgets/password_pin_setup.dart';
import 'package:flutter/material.dart';
import 'recovery_phrase_screen.dart';

class PinSetupScreen extends StatelessWidget {
  final String network;
  const PinSetupScreen({super.key, required this.network});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: TextButton(
                  style: TextButton.styleFrom(foregroundColor: Colors.black),
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.arrow_back),
                      SizedBox(width: 8),
                      Text('Back'),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: PasswordPinSetupWidget(
                  imageAsset: 'assets/images/setup_pin.svg',
                  imageHeight: 374,
                  title: 'Set up your PIN',
                  subtext:
                      'This pin is required to unlock your password on your device. This PIN makes it easier to use the wallet without requiring to enter the password everytime. You can also enable the biometric authentication to unlock your password.',
                  isPin: true,
                  onContinue: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => RecoveryPhraseScreen(),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
