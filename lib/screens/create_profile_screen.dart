import 'package:eto_pay/screens/password_setup_screen.dart';
import 'package:eto_pay/widgets/onboarding.dart';
import 'package:flutter/material.dart';

class CreateProfileScreen extends StatelessWidget {
  const CreateProfileScreen({super.key, required this.network});
  final String network;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextButton(
              style: TextButton.styleFrom(foregroundColor: Colors.black),
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.arrow_back),
                  SizedBox(width: 8),
                  Text('Back'),
                ],
              ),
            ),
            Expanded(
              child: ImageCardListWidget(
                svgAssetPath: 'assets/images/create_wallet_bg.svg',
                textData: network,
                subtitle: 'How do you want to create your profile?',
                cards: [
                  CardData(
                    title: 'Create a software profile',
                    subtitle:
                        'creates a software wallet with a recovery phrase',
                    icon: Icons.folder_outlined,
                    onTap: () => Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) =>
                            PasswordSetupScreen(network: network),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
