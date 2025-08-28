import 'package:eto_pay/screens/home_and_inner_pages/history_shell/blue_background.dart';
import 'package:eto_pay/screens/home_and_inner_pages/history_shell/transaction_details_dialog.dart';
import 'package:eto_pay/screens/home_and_inner_pages/top_bar_avatar_network_notifications.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HistoryShellScreen extends StatefulWidget {
  const HistoryShellScreen({super.key});

  @override
  State<HistoryShellScreen> createState() => _HistoryShellScreenState();
}

class _HistoryShellScreenState extends State<HistoryShellScreen> {
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TopBarAvatarNetworkNotifications(
                selectedNetwork: _selectedNetwork,
                networkIcons: _networkIcons,
                notificationsCount: _notificationsCount,
                onNetworkChanged: _handleNetworkChange,
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: const Color(0xFFF5F5F5),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: const TextField(
                        decoration: InputDecoration(
                          icon: Icon(Icons.search),
                          hintText: 'Search transactions',
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          height: 35,
                          child: TextButton(
                            style: TextButton.styleFrom(
                              backgroundColor: const Color(0xFFF5F5F5),
                              padding: const EdgeInsets.symmetric(
                                vertical: 8,
                                horizontal: 10,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(6),
                              ),
                            ),
                            onPressed: () {},
                            child: Row(
                              children: const [
                                Text('Download transactions',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold)),
                                SizedBox(width: 6),
                                Icon(Icons.download, size: 16),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 35,
                          child: TextButton(
                            style: TextButton.styleFrom(
                              backgroundColor: const Color(0xFFF5F5F5),
                              padding: const EdgeInsets.symmetric(
                                vertical: 8,
                                horizontal: 10,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(6),
                              ),
                            ),
                            onPressed: () {},
                            child: Row(
                              children: const [
                                Text('Filters',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold)),
                                SizedBox(width: 6),
                                Icon(Icons.filter_list, size: 16),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    ListView(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      children: [
                        TransactionSection(
                          title: 'Today',
                          transactions: [
                            TransactionData(
                              icon: SvgPicture.asset(
                                "assets/icons/icon_eth.svg",
                                width: 20,
                                height: 20,
                              ),
                              label: 'ETH',
                              subtitle: 'Receive 12:32',
                              amount: '+ € 430.00',
                            ),
                            TransactionData(
                              icon: SvgPicture.asset(
                                "assets/icons/icon_btc.svg",
                                width: 20,
                                height: 20,
                              ),
                              label: 'BTC',
                              subtitle: 'Sent 10:10',
                              amount: '-€ 20.00',
                            ),
                          ],
                        ),
                        TransactionSection(
                          title: 'Yesterday',
                          transactions: [
                            TransactionData(
                              icon: SvgPicture.asset(
                                "assets/icons/icon_btc.svg",
                                width: 20,
                                height: 20,
                              ),
                              label: 'BTC',
                              subtitle: 'Sent 16:45',
                              amount: '-€ 12.50',
                            ),
                          ],
                        ),
                        TransactionSection(
                          title: '30-07-2024, Tue',
                          transactions: [
                            TransactionData(
                              icon: SvgPicture.asset(
                                "assets/icons/icon_btc.svg",
                                width: 20,
                                height: 20,
                              ),
                              label: 'BTC',
                              subtitle: 'Sent 08:15',
                              amount: '-€ 45.00',
                            ),
                            TransactionData(
                              icon: SvgPicture.asset(
                                "assets/icons/icon_eth.svg",
                                width: 20,
                                height: 20,
                              ),
                              label: 'ETH',
                              subtitle: 'Receive 18:30',
                              amount: '+€ 430.00',
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class TransactionSection extends StatelessWidget {
  final String title;
  final List<TransactionData> transactions;

  const TransactionSection({
    super.key,
    required this.title,
    required this.transactions,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 16),
        Text(
          title,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        Column(
          children:
              transactions.map((tx) => TransactionTile(data: tx)).toList(),
        ),
      ],
    );
  }
}

class TransactionData {
  final SvgPicture icon;
  final String label;
  final String subtitle;
  final String amount;

  const TransactionData({
    required this.icon,
    required this.label,
    required this.subtitle,
    required this.amount,
  });
}

class TransactionTile extends StatelessWidget {
  final TransactionData data;

  const TransactionTile({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    final bool isNegative = data.amount.trim().startsWith('-');

    return Container(
      height: 68,
      margin: const EdgeInsets.symmetric(vertical: 6),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6),
        boxShadow: const [
          BoxShadow(
            color: Color.fromARGB(102, 105, 105, 105),
            blurRadius: 4,
            offset: Offset(0, 0),
          ),
        ],
      ),
      child: Material(
        color: Colors.white,
        borderRadius: BorderRadius.circular(6),
        child: InkWell(
          borderRadius: BorderRadius.circular(6),
          onTap: () {
            showDialog(
              context: context,
              builder: (context) => TransactionDetailsDialog(
                type: 'Sent ${data.label}',
                isConfirmed: true,
                amountBTC: '0.623${data.label}',
                amountFiat: '€ 35.23',
                from: 'Dashgvkas',
                to: 'JHbklmsjn',
                date: 'Jul 31 at 12:32',
              ),
            );
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Row(
              children: [
                data.icon,
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        data.label,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        data.subtitle,
                        style: const TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      data.amount,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: isNegative ? Colors.red : Colors.green,
                      ),
                    ),
                  ],
                ),
                const SizedBox(width: 8),
                const Icon(Icons.chevron_right),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
