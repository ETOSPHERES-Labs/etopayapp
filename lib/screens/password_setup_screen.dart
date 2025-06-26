import 'package:eto_pay/widgets/password_pin_setup.dart';
import 'package:flutter/material.dart';
import 'pin_setup_screen.dart';

class PasswordSetupScreen extends StatelessWidget {
  final String network;
  const PasswordSetupScreen({super.key, required this.network});

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
                  imageAsset: 'assets/images/create_password.svg',
                  imageHeight: 374,
                  title: 'Create your new password',
                  subtext:
                      'This password is required to verify that it is you when someone operates the wallet',
                  onContinue: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => PinSetupScreen(network: network),
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
