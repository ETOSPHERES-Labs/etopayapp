import 'package:eto_pay/screens/enter_recovery_phrase_screen.dart';
import 'package:eto_pay/widgets/onboarding.dart';
import 'package:flutter/material.dart';

class ImportExistingWalletScreen extends StatelessWidget {
  const ImportExistingWalletScreen({super.key, required this.network});
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
                svgAssetPath: 'assets/images/import_existing_wallet.svg',
                textData: 'Recover $network profile',
                subtitle: 'If you have an existing mnemonic or Stronghold backup file, you can import it here.',
                cards: [
                  CardData(
                    title: 'Use recovery phrase',
                    subtitle: 'Enter your 24-word mnemonic phrase',
                    icon: Icons.folder_outlined,
                    onTap: () => Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) =>
                            EnterRecoveryPhraseScreen(network: network),
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
