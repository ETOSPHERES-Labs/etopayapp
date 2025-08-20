import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
      builder: (context) {
        return SizedBox(
          height: 250,
          child: Column(
            children: [
              const SizedBox(height: 16),
              const Text(
                'Select Network',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const Divider(),
              ListTile(
                leading: const Icon(Icons.location_on),
                title: const Text('Shimmer Network'),
                onTap: () {
                  setState(() => _selectedNetwork = 'Shimmer Network');
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: const Icon(Icons.location_on),
                title: const Text('ETH Network'),
                onTap: () {
                  setState(() => _selectedNetwork = 'ETH Network');
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: const Icon(Icons.location_on),
                title: const Text('Binance Network'),
                onTap: () {
                  setState(() => _selectedNetwork = 'Binance Network');
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Container(
              height: 150,
              decoration: const BoxDecoration(
                color: Color(0xFF005CA9),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(24),
                  bottomRight: Radius.circular(24),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  child: Row(
                    children: [
                      const CircleAvatar(
                        radius: 20,
                        backgroundImage: AssetImage('assets/images/avatar.png'),
                      ),
                      const SizedBox(width: 12),
                      InkWell(
                        onTap: _openCityPicker,
                        borderRadius: BorderRadius.circular(8),
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        hoverColor: Colors.transparent,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 6),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              if (_networkIcons[_selectedNetwork] != null)
                                Padding(
                                  padding: const EdgeInsets.only(right: 6),
                                  child: SvgPicture.asset(
                                    _networkIcons[_selectedNetwork]!,
                                    width: 20,
                                    height: 20,
                                  ),
                                ),
                              const SizedBox(width: 4),
                              Text(
                                _selectedNetwork,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.normal,
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(width: 4),
                              const Icon(
                                Icons.keyboard_arrow_down_rounded,
                                size: 20,
                                color: Colors.white,
                              ),
                            ],
                          ),
                        ),
                      ),
                      const Spacer(),
                      Stack(
                        alignment: Alignment.topRight,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.notifications_none,
                                color: Colors.white, size: 32),
                            onPressed: () {},
                          ),
                          if (_notificationsCount > 0)
                            Positioned(
                              right: 6,
                              top: 12,
                              child: Container(
                                padding: const EdgeInsets.all(4),
                                decoration: const BoxDecoration(
                                  color: Colors.red,
                                  shape: BoxShape.circle,
                                ),
                                constraints: const BoxConstraints(
                                  minWidth: 18,
                                  minHeight: 18,
                                ),
                                child: Text(
                                  '$_notificationsCount',
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 8,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 8),
                const InfoCard(), 
                const SizedBox(height: 18),
                const ActionButtonsRow(),
                const CryptoAddressSection(),
                Expanded(child: const TokenTabSection()), 
              ],
            ),
          ),
        ],
      ),
    );
  }
}
