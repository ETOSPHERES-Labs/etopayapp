import 'package:flutter/material.dart';

class CryptoSwapWidget extends StatefulWidget {
  const CryptoSwapWidget({super.key});

  @override
  State<CryptoSwapWidget> createState() => _CryptoSwapWidgetState();
}

class _CryptoSwapWidgetState extends State<CryptoSwapWidget> {
  String fromSymbol = 'ETH';
  String fromName = 'Ethereum';
  double fromAmount = 0.4;
  double fromBalance = 0;

  String toSymbol = 'BNB';
  String toName = 'Binance Coin';
  double toAmount = 0.0;
  double toBalance = 0.12;

  void _showCurrencyPicker(bool isFrom) async {
    final result = await showModalBottomSheet<Map<String, String>>(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) {
        return ListView(
          children: [
            ListTile(
              leading: const CircleAvatar(child: Text('₿')),
              title: const Text('Bitcoin'),
              subtitle: const Text('BTC'),
              onTap: () =>
                  Navigator.pop(context, {'symbol': 'BTC', 'name': 'Bitcoin'}),
            ),
            ListTile(
              leading: const CircleAvatar(child: Text('Ξ')),
              title: const Text('Ethereum'),
              subtitle: const Text('ETH'),
              onTap: () =>
                  Navigator.pop(context, {'symbol': 'ETH', 'name': 'Ethereum'}),
            ),
            ListTile(
              leading: const CircleAvatar(child: Text('🟡')),
              title: const Text('Binance Coin'),
              subtitle: const Text('BNB'),
              onTap: () => Navigator.pop(
                  context, {'symbol': 'BNB', 'name': 'Binance Coin'}),
            ),
          ],
        );
      },
    );

    if (result != null) {
      setState(() {
        if (isFrom) {
          fromSymbol = result['symbol']!;
          fromName = result['name']!;
        } else {
          toSymbol = result['symbol']!;
          toName = result['name']!;
        }
      });
    }
  }

  Widget _buildCryptoSection({
    required String label,
    required String symbol,
    required String name,
    required double amount,
    required double balance,
    required VoidCallback onSelect,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(color: Colors.grey)),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              const CircleAvatar(radius: 14, child: Text('🪙')),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        GestureDetector(
                          onTap: onSelect,
                          child: Row(
                            children: [
                              Text(
                                symbol,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 16),
                              ),
                              const Icon(Icons.keyboard_arrow_down),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        const SizedBox(height: 8),
                        Text(
                          name,
                          style:
                              const TextStyle(color: Colors.grey, fontSize: 14),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    'Balance : $balance',
                    style: const TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                  const SizedBox(height: 4),
                  const Text('€ 0.00',
                      style: TextStyle(fontSize: 12, color: Colors.grey)),
                  Text(
                    '$amount $symbol',
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                ],
              )
            ],
          ),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildCryptoSection(
          label: 'From',
          symbol: fromSymbol,
          name: fromName,
          amount: fromAmount,
          balance: fromBalance,
          onSelect: () => _showCurrencyPicker(true),
        ),
        const SizedBox(height: 12),
        const Icon(Icons.swap_vert, size: 24),
        const SizedBox(height: 12),
        _buildCryptoSection(
          label: 'To',
          symbol: toSymbol,
          name: toName,
          amount: toAmount,
          balance: toBalance,
          onSelect: () => _showCurrencyPicker(false),
        ),
      ],
    );
  }
}
