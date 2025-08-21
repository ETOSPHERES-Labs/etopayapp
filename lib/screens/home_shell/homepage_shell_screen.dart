import 'package:eto_pay/screens/home_shell/topbar.dart';
import 'package:flutter/material.dart';
import 'package:eto_pay/screens/home_shell/action_button_row.dart';
import 'package:eto_pay/screens/home_shell/crypto_address_section.dart';
import 'package:eto_pay/screens/home_shell/info_card.dart';
import 'package:eto_pay/screens/home_shell/token_tab_section.dart';

class HomePageShellScreen extends StatefulWidget {
  const HomePageShellScreen({super.key});

  @override
  State<HomePageShellScreen> createState() => _HomePageState();
}

class _HomePageState extends State<HomePageShellScreen> {
  String _selectedNetwork = 'Shimmer Network';
  int _notificationsCount = 3;

  final Map<String, String> _networkIcons = {
    'Shimmer Network': 'assets/icons/icon_shimmer.svg',
    'ETH Network': 'assets/icons/icon_eth.svg',
    'Binance Network': 'assets/icons/icon_binance.svg',
  };

  void _openCityPicker() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) => SizedBox(
        height: 250,
        child: Column(
          children: [
            const SizedBox(height: 16),
            const Text(
              'Select Network',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const Divider(),
            ..._networkIcons.keys.map((network) => ListTile(
                  leading: const Icon(Icons.location_on),
                  title: Text(network),
                  onTap: () {
                    setState(() => _selectedNetwork = network);
                    Navigator.pop(context);
                  },
                )),
          ],
        ),
      ),
    );
  }

  @override
Widget build(BuildContext context) {
  return SafeArea(
    child: SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TopBar(
            selectedNetwork: _selectedNetwork,
            networkIcons: _networkIcons,
            notificationsCount: _notificationsCount,
            onNetworkTap: _openCityPicker,
          ),
          const SizedBox(height: 8),
          const InfoCard(),
          const SizedBox(height: 18),
          const ActionButtonsRow(),
          const CryptoAddressSection(),
          const SizedBox(height: 16),
          ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: 116,
              maxHeight: 116 + 64 * 3, 
            ),
            child: const TokenTabSection(),
          ),
        ],
      ),
    ),
  );
}

}
