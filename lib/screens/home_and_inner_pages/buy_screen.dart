import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BuyScreen extends StatefulWidget {
  const BuyScreen({super.key});

  @override
  State<BuyScreen> createState() => _BuyScreenState();
}

class _BuyScreenState extends State<BuyScreen> {
  final textStyleAbove = const TextStyle(
    fontFamily: 'Roboto',
    fontWeight: FontWeight.w400,
    fontSize: 14,
    color: Color(0xFF747474),
    height: 1.0,
  );

  final textStyleBelow = const TextStyle(
    fontFamily: 'Roboto',
    fontWeight: FontWeight.w400,
    fontSize: 12,
    color: Color(0xFF747474),
    height: 1.0,
  );

  String _selectedBuyCoin = 'SMR';
  String _selectedAmountCurrency = 'EURO';
  String _selectedAmountValue = '0';
  String _selectedPaymentMethod = 'Sepa';

  final List<Map<String, String>> _coins = [
    {
      'name': 'Shimmer',
      'symbol': 'SMR',
      'icon': 'assets/icons/icon_shimmer.svg'
    },
    {'name': 'Ethereum', 'symbol': 'ETH', 'icon': 'assets/icons/icon_eth.svg'},
    {'name': 'Duno', 'symbol': 'DUNO', 'icon': 'assets/icons/icon_duno.svg'},
  ];

  final List<String> _presetAmounts = ["1,000", "2,500", "5,000", "10,000"];

  final List<Map<String, String>> _paymentMethods = [
    {
      'label': 'Sepa',
      'icon': 'assets/icons/icon_sepa.svg',
    },
    {
      'label': 'CC',
      'icon': 'assets/icons/icon_cc.svg',
    },
    {
      'label': 'Paypal',
      'icon': 'assets/icons/icon_paypal.svg',
    },
  ];

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> _fiats = [
      {
        'name': _selectedAmountValue,
        'symbol': 'EURO',
        'icon': 'assets/icons/icon_euro.svg',
        'paint_in_gray': 'true'
      },
      {
        'name': _selectedAmountValue,
        'symbol': 'USD',
        'icon': 'assets/icons/icon_usd.svg',
      },
    ];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF005CA9),
        elevation: 0,
        leadingWidth: 120,
        leading: Row(
          children: [
            IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () => Navigator.of(context).pop(),
            ),
            const Text(
              'Buy SMR',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            const SizedBox(height: 24),
            Align(
              alignment: Alignment.centerLeft,
              child: Text("You want to buy", style: textStyleAbove),
            ),
            const SizedBox(height: 6),
            _buildDropdownBox(
              items: _coins,
              selectedSymbol: _selectedBuyCoin,
              onChanged: (val) => setState(() => _selectedBuyCoin = val!),
            ),
            const SizedBox(height: 4),
            Align(
              alignment: Alignment.centerLeft,
              child: Text("Current balance: 0 $_selectedBuyCoin = 0 EUR",
                  style: textStyleBelow),
            ),
            const SizedBox(height: 24),
            Align(
              alignment: Alignment.centerLeft,
              child: Text("Amount", style: textStyleAbove),
            ),
            const SizedBox(height: 6),
            _buildDropdownBox(
              items: _fiats,
              selectedSymbol: _selectedAmountCurrency,
              onChanged: (val) =>
                  setState(() => _selectedAmountCurrency = val!),
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: _presetAmounts.map((amount) {
                return _buildAmountButton(amount);
              }).toList(),
            ),
            const SizedBox(height: 32),
            Align(
              alignment: Alignment.centerLeft,
              child: Text("Update payment method", style: textStyleAbove),
            ),
            const SizedBox(height: 8),
            InkWell(
              onTap: () {
                _showPaymentMethodBottomSheet(context);
              },
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                decoration: BoxDecoration(
                  color: const Color(0xFFF0F0F0),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        SvgPicture.asset(
                          _paymentMethods.firstWhere((pm) =>
                              pm['label'] == _selectedPaymentMethod)['icon']!,
                          width: 24,
                          height: 24,
                        ),
                        const SizedBox(width: 8),
                        Text(_selectedPaymentMethod, style: TextStyle(fontWeight: FontWeight.bold)),
                      ],
                    ),
                    Container(
                      width: 32,
                      height: 32,
                      decoration: const BoxDecoration(
                        color: Color(0xFF005CA9),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.arrow_forward,
                          size: 18, color: Colors.white),
                    ),
                  ],
                ),
              ),
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF005CA9),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: () {
                  // TODO: handle buy logic
                },
                child: const Text("Buy", style: TextStyle(color: Colors.white)),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildDropdownBox({
    required List<Map<String, String>> items,
    required String selectedSymbol,
    required void Function(String?) onChanged,
  }) {
    return DropdownButtonFormField<String>(
      value: selectedSymbol,
      decoration: InputDecoration(
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFF005CA9), width: 2),
        ),
      ),
      icon: const Icon(Icons.keyboard_arrow_down),
      isExpanded: true,
      onChanged: onChanged,
      items: items.map((item) {
        return DropdownMenuItem(
          value: item['symbol'],
          child: Row(
            children: [
              if (item["paint_in_gray"] != null)
                SvgPicture.asset(item['icon']!,
                    width: 24,
                    height: 24,
                    colorFilter: const ColorFilter.mode(
                      Color(0xFF747474),
                      BlendMode.srcIn,
                    ))
              else
                SvgPicture.asset(item['icon']!, width: 24, height: 24),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  item['name']!,
                  style: const TextStyle(color: Colors.black),
                ),
              ),
              Text(item['symbol']!,
                  style: const TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold)),
            ],
          ),
        );
      }).toList(),
    );
  }

  Widget _buildAmountButton(String label) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 18),
            backgroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
              side: const BorderSide(
                color: Color(0xFF005CA9),
                width: 1,
              ),
            ),
          ),
          onPressed: () {
            setState(() {
              _selectedAmountValue = label;
            });
          },
          child: Text(
            label,
            style: const TextStyle(
              color: Colors.black,
            ),
          ),
        ),
      ),
    );
  }

  void _showPaymentMethodBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                "Select payment method",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 16),
              ..._paymentMethods.map((method) {
                return MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedPaymentMethod = method['label']!;
                      });
                      Navigator.pop(context);
                    },
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 12),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 12),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF0F0F0),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              SvgPicture.asset(
                                method['icon']!,
                                width: 24,
                                height: 24,
                              ),
                              const SizedBox(width: 8),
                              Text(method['label']!, style: TextStyle(fontWeight: FontWeight.bold)),
                            ],
                          ),
                          const SizedBox(height: 4),
                          Row(
                            children: [
                              SvgPicture.asset(
                                'assets/icons/icon_time.svg',
                                width: 16,
                                height: 16,
                                colorFilter: const ColorFilter.mode(
                                  Color(0xFF747474),
                                  BlendMode.srcIn,
                                ),
                              ),
                              const SizedBox(width: 6),
                              const Text(
                                "Instant.",
                                style: TextStyle(
                                  fontFamily: 'Roboto',
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14,
                                  height: 22 / 14,
                                  color: Color(0xFF747474),
                                ),
                              ),
                              const SizedBox(width: 8),
                              SvgPicture.asset(
                                'assets/icons/icon_euro.svg',
                                width: 12,
                                height: 12,
                                colorFilter: const ColorFilter.mode(
                                  Color(0xFF747474),
                                  BlendMode.srcIn,
                                ),
                              ),
                              const SizedBox(width: 6),
                              const Text(
                                "highest buy limit",
                                style: TextStyle(
                                  fontFamily: 'Roboto',
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14,
                                  height: 22 / 14,
                                  color: Color(0xFF747474),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }).toList(),
            ],
          ),
        );
      },
    );
  }
}
