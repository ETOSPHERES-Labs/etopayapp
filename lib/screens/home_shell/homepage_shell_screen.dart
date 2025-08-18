import 'package:eto_pay/screens/home_shell/action_button_row.dart';
import 'package:eto_pay/screens/home_shell/crypto_address_section.dart';
import 'package:eto_pay/screens/home_shell/info_card.dart';
import 'package:eto_pay/screens/home_shell/token_tab_section.dart';
import 'package:flutter/material.dart';

class HomePageShellScreen extends StatefulWidget {
  const HomePageShellScreen({super.key});

  @override
  State<HomePageShellScreen> createState() => _HomePageState();
}

class _HomePageState extends State<HomePageShellScreen> {
  String _selectedNetwork = 'Shimmer Network';
  int _notificationsCount = 3;

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
                title: const Text('BTC Network'),
                onTap: () {
                  setState(() => _selectedNetwork = 'BTC Network');
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
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Row(
            children: [
              // 🧑‍🦱 Avatar
              const CircleAvatar(
                radius: 20,
                backgroundImage: AssetImage('assets/images/avatar.png'),
              ),
              const SizedBox(width: 12),

              // ⬇️ Klikalny "dropdown"
              Expanded(
                child: InkWell(
                  onTap: _openCityPicker,
                  borderRadius: BorderRadius.circular(8),
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  hoverColor: Colors.transparent,
                  child: Row(
                    children: [
                      Icon(Icons.location_on_outlined, color: Colors.grey[700]),
                      const SizedBox(width: 4),
                      Text(
                        _selectedNetwork,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(width: 4),
                      Icon(
                        Icons.keyboard_arrow_down_rounded,
                        size: 20,
                        color: Colors.grey[700],
                      ),
                    ],
                  ),
                ),
              ),

              // 🔔 Dzwonek z badge'em
              Stack(
                alignment: Alignment.topRight,
                children: [
                  IconButton(
                    icon: const Icon(Icons.notifications_none),
                    onPressed: () {
                      // Możesz tu dodać obsługę kliknięcia
                    },
                  ),
                  if (_notificationsCount > 0)
                    Positioned(
                      right: 6,
                      top: 6,
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
                            fontSize: 10,
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
        // 🟦 InfoCard
        const SizedBox(height: 8),
        const InfoCard(),
        const SizedBox(height: 18),
        const ActionButtonsRow(),
        const CryptoAddressSection(),
        const SizedBox(height: 18),
        const TokenTabSection()
      ],
    ));
  }
}
