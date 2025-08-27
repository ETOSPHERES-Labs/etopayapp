import 'package:eto_pay/screens/home_shell/top_bar_avatar_network_notifications.dart';
import 'package:flutter/material.dart';
import 'package:eto_pay/screens/home_shell/buy_sell_bridge_buttons_row.dart';
import 'package:eto_pay/screens/home_shell/receive_send_funds_section.dart';
import 'package:eto_pay/screens/home_shell/balance_info_card.dart';
import 'package:eto_pay/screens/home_shell/tokens_nfts_erc20_tab_section.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'blue_background.dart';

class HomeShellScreen extends StatefulWidget {
  const HomeShellScreen({super.key});

  @override
  State<HomeShellScreen> createState() => _HomePageState();
}

class _HomePageState extends State<HomeShellScreen> {
  String _selectedNetwork = 'Shimmer Network';
  int _notificationsCount = 3;

  final Map<String, String> _networkIcons = {
    'Shimmer Network': 'assets/icons/icon_shimmer.svg',
    'ETH Network': 'assets/icons/icon_eth.svg',
    'Binance Network': 'assets/icons/icon_binance.svg',
  };

  void _openCityPicker() {
  showDialog(
    context: context,
    builder: (context) {
      return Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        clipBehavior: Clip.antiAlias, 
        child: Material(
          color: Colors.white,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Select Network',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ],
                ),
              ),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: _networkIcons.entries.map((entry) {
                    final isSelected = entry.key == _selectedNetwork;

                    return InkWell(
                      borderRadius: BorderRadius.circular(12),
                      onTap: () {
                        setState(() => _selectedNetwork = entry.key);
                        Navigator.pop(context);
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                        margin: const EdgeInsets.symmetric(vertical: 6),
                        decoration: BoxDecoration(
                          color: isSelected ? const Color(0xFFE6F0FF) : Colors.transparent,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          children: [
                            SvgPicture.asset(
                              entry.value,
                              width: 24,
                              height: 24,
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Text(
                                entry.key,
                                style: const TextStyle(fontSize: 16),
                              ),
                            ),
                            if (isSelected)
                              Container(
                                width: 24,
                                height: 24,
                                decoration: BoxDecoration(
                                  color: const Color(0xFF005CA9),
                                  shape: BoxShape.circle,
                                ),
                                child: const Icon(
                                  Icons.check,
                                  color: Colors.white,
                                  size: 16,
                                ),
                              ),
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),

              const SizedBox(height: 8),

              Padding(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF005CA9),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6),
                      ),
                      padding: const EdgeInsets.fromLTRB(14, 18, 14, 18),
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text(
                      'Add Network',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: CustomPaint(
          painter: BlueBackgroundPainter(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TopBarAvatarNetworkNotifications(
                selectedNetwork: _selectedNetwork,
                networkIcons: _networkIcons,
                notificationsCount: _notificationsCount,
                onNetworkTap: _openCityPicker,
              ),
              const SizedBox(height: 8),
              const BalanceInfoCard(),
              const SizedBox(height: 18),
              const BuySellBridgeButtonsRow(),
              const ReceiveSendFundsSection(),
              const SizedBox(height: 16),
              ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: 116,
                  maxHeight: 116 + 64 * 3,
                ),
                child: const TokensNfcsErc20TabSection(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
