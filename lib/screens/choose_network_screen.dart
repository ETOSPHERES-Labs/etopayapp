import 'package:eto_pay/screens/choose_custom_network_screen.dart';
import 'package:eto_pay/screens/wallet_options_screen.dart';
import 'package:eto_pay/widgets/conditional_button.dart';
import 'package:eto_pay/widgets/onboarding.dart';
import 'package:flutter/material.dart';

class ChooseNetworkScreen extends StatelessWidget {
  const ChooseNetworkScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextButton(
                  style: TextButton.styleFrom(foregroundColor: Colors.black),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Row(
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
                    svgAssetPath: 'assets/images/choose_network_bg.svg',
                    textData: 'Choose Network',
                    subtitle: 'Select the network for your profile',
                    cards: [
                      CardData(
                        title: 'EVM-based',
                        subtitle: 'Most common',
                        icon: Icons.account_balance_wallet_outlined,
                        onTap: () => Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => const WalletOptionsScreen(
                              network: 'EVM-based',
                            ),
                          ),
                        ),
                      ),
                      CardData(
                        title: 'IOTA',
                        subtitle: 'Feeless IOTA network',
                        icon: Icons.account_balance_wallet_outlined,
                        onTap: () => Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => const WalletOptionsScreen(
                              network: 'IOTA',
                            ),
                          ),
                        ),
                      ),
                      CardData(
                        title: 'ERC20-based',
                        subtitle: 'Ethereum tokens',
                        icon: Icons.account_balance_wallet_outlined,
                        onTap: () => Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => const ChooseCustomNetworkScreen(),
                          ),
                        ),
                      ),
                    ],
                    footer: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const SizedBox(height: 24),
                        const Row(
                          children: [
                            Expanded(child: Divider()),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 16.0),
                              child: Text('or login with'),
                            ),
                            Expanded(child: Divider()),
                          ],
                        ),
                        const SizedBox(height: 24),
                        ConditionalButton(
                          isActive: true,
                          onPressed: () {},
                          text: 'Guest',
                        )
                      ],
                    ),
                  ),
                ),
              ],
            )));
  }
}
