import 'package:eto_pay/screens/create_profile_screen.dart';
import 'package:eto_pay/screens/import_existing_wallet_screen.dart';
import 'package:eto_pay/widgets/onboarding.dart';
import 'package:flutter/material.dart';

class WalletOptionsScreen extends StatelessWidget {
  const WalletOptionsScreen({super.key, required this.network});
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
                subtitle: 'Select how you want to setup your wallet',
                cards: [
                  CardData(
                    title: 'Create new wallet',
                    subtitle: 'Create a new secure wallet',
                    icon: Icons.add_box_outlined,
                    onTap: () => Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) =>
                          CreateProfileScreen(network: network),
                    )),
                  ),
                  CardData(
                    title: 'Import an existing wallet',
                    subtitle: 'Import your existing wallet securely',
                    icon: Icons.download_for_offline_outlined,
                    onTap: () => Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) =>
                          ImportExistingWalletScreen(network: network),
                    )),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
