import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class TokenTabSection extends StatefulWidget {
  const TokenTabSection({super.key});

  @override
  State<TokenTabSection> createState() => _TokenTabSectionState();
}

class _TokenTabSectionState extends State<TokenTabSection>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  final List<Map<String, dynamic>> _tokens = [
    {
      'icon': SvgPicture.asset(
        "assets/icons/icon_eth.svg",
        width: 20,
        height: 20,
      ),
      'name': 'Ethereum',
      'price': '€ 1.234,7',
      'amount': '2.6348 ETH',
      'change': 4.07,
    },
    {
      'icon': SvgPicture.asset(
        "assets/icons/icon_binance.svg",
        width: 20,
        height: 20,
      ),
      'name': 'Binance',
      'price': '€ 1.034,7',
      'amount': '3.2348 BNB',
      'change': -2.15,
    },
    {
      'icon': SvgPicture.asset(
        "assets/icons/icon_razer.svg",
        width: 20,
        height: 20,
      ),
      'name': 'Razer',
      'price': '€ 2.234,7',
      'amount': '4.1368 RRR',
      'change': 1.23,
    },
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 24, left: 20, right: 20, bottom: 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TabBar(
            controller: _tabController,
            labelColor: Colors.black,
            unselectedLabelColor: Colors.grey,
            labelStyle: const TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 14,
            ),
            indicatorColor: const Color(0xFF005CA9),
            tabs: const [
              Tab(text: 'Tokens'),
              Tab(text: 'NFTs'),
              Tab(text: 'ERC20'),
            ],
          ),
          const SizedBox(height: 12),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                if(_tokens.isNotEmpty) _buildTokenListWithBackground()
                else const Center(child: Text('Tokens (empty)')),
                const Center(child: Text('NFTs (empty)')),
                const Center(child: Text('ERC20 (empty)')),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTokenListWithBackground() {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFF0F0F0),
        borderRadius: BorderRadius.circular(8),
      ),
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
      child: _buildTokenListInner(),
    );
  }

  Widget _buildTokenListInner() {
    return Column(
      children: List.generate(_tokens.length * 2 - 1, (index) {
        if (index.isOdd) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 6),
            child: Container(height: 1, color: Colors.grey[300]),
          );
        }
        final tokenIndex = index ~/ 2;
        final token = _tokens[tokenIndex];
        final isPositive = token['change'] >= 0;
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
          child: Row(
            children: [
              token['icon'],
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      token['name'],
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      token['price'],
                      style: const TextStyle(
                        fontSize: 12,
                        color: Color(0xFF747474),
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    token['amount'],
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Row(
                    children: [
                      Icon(
                        isPositive ? Icons.arrow_upward : Icons.arrow_downward,
                        size: 12,
                        color: isPositive ? Colors.green : Colors.red,
                      ),
                      const SizedBox(width: 2),
                      Text(
                        '${token['change'].abs().toStringAsFixed(2)}%',
                        style: TextStyle(
                          fontSize: 12,
                          color: isPositive ? Colors.green : Colors.red,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        );
      }),
    );
  }
}
