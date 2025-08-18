import 'package:flutter/material.dart';

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
      'icon': Icons.currency_bitcoin,
      'name': 'Bitcoin',
      'price': '€ 27,500',
      'amount': '0.015 BTC',
      'change': 4.07,
    },
    {
      'icon': Icons.currency_lira,
      'name': 'Ethereum',
      'price': '€ 1,650',
      'amount': '1.2 ETH',
      'change': -2.15,
    },
    {
      'icon': Icons.currency_yuan,
      'name': 'Solana',
      'price': '€ 95',
      'amount': '12.5 SOL',
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
          SizedBox(
            height: 200, 
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildTokenList(),
                const Center(child: Text('NFTs (empty)')),
                const Center(child: Text('ERC20 (empty)')),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTokenList() {
    return ListView.separated(
      itemCount: _tokens.length,
      separatorBuilder: (_, __) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 0),
        child: Align(
          alignment: Alignment.center,
          child: FractionallySizedBox(
            widthFactor: 1,
            child: Container(
              height: 1,
              color: Colors.grey[300],
            ),
          ),
        ),
      ),
      itemBuilder: (context, index) {
        final token = _tokens[index];
        final isPositive = token['change'] >= 0;
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
          decoration: BoxDecoration(
            color: const Color(0xFFF0F0F0),
            borderRadius: BorderRadius.circular(6),
          ),
          child: Row(
            children: [
              Icon(token['icon'], size: 32, color: Colors.grey[800]),
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
                    '${token['amount']}',
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
      },
    );
  }
}
