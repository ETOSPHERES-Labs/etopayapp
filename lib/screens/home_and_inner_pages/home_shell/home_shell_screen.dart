import 'package:flutter/material.dart';
import 'package:eto_pay/screens/home_and_inner_pages/top_bar_avatar_network_notifications.dart';
import 'package:eto_pay/screens/home_and_inner_pages/home_shell/buy_sell_bridge_buttons_row.dart';
import 'package:eto_pay/screens/home_and_inner_pages/home_shell/receive_send_funds_section.dart';
import 'package:eto_pay/screens/home_and_inner_pages/home_shell/balance_info_card.dart';
import 'package:eto_pay/screens/home_and_inner_pages/home_shell/tokens_nfts_erc20_tab_section.dart';

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

  void _handleNetworkChange(String newNetwork) {
    setState(() {
      _selectedNetwork = newNetwork;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: CustomPaint(
          painter: BlueBackgroundPainter(),
          child:Column(
            
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TopBarAvatarNetworkNotifications(
                selectedNetwork: _selectedNetwork,
                networkIcons: _networkIcons,
                notificationsCount: _notificationsCount,
                onNetworkChanged: _handleNetworkChange,
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
