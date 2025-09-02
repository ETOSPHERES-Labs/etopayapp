import 'package:eto_pay/screens/home_and_inner_pages/buy_screen/widgets/amount_input.dart';
import 'package:eto_pay/screens/home_and_inner_pages/buy_screen/widgets/coin_dropdown.dart';
import 'package:eto_pay/screens/home_and_inner_pages/buy_screen/widgets/payment_method_bottom_sheet.dart';
import 'package:eto_pay/screens/home_and_inner_pages/buy_screen/widgets/payment_method_selector.dart';
import 'package:eto_pay/screens/home_and_inner_pages/buy_screen/widgets/preset_amount_buttons.dart';
import 'package:eto_pay/screens/home_and_inner_pages/buy_screen/widgets/section_title.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BuyScreen extends StatefulWidget {
  const BuyScreen({Key? key}) : super(key: key);

  @override
  State<BuyScreen> createState() => _BuyScreenState();
}

class _BuyScreenState extends State<BuyScreen> {
  final TextEditingController _amountController = TextEditingController();

  String _selectedCoin = 'SMR';
  String _selectedCurrency = 'EURO';
  String _selectedPaymentMethod = 'Sepa';

  final List<Map<String, String>> _coins = [
    {
      'name': 'Shimmer',
      'symbol': 'SMR',
      'icon': 'assets/icons/icon_shimmer.svg'
    },
    {
      'name': 'Ethereum',
      'symbol': 'ETH',
      'icon': 'assets/icons/icon_eth.svg',
      'paint_in_gray': 'true'
    },
    {'name': 'Duno', 'symbol': 'DUNO', 'icon': 'assets/icons/icon_duno.svg'},
  ];

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

  final List<String> _presetAmounts = ['25', '50', '100', '250'];

  void _showPaymentMethodSheet() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (_) {
        return PaymentMethodBottomSheet(
          paymentMethods: _paymentMethods,
          onSelect: (method) {
            setState(() {
              _selectedPaymentMethod = method;
            });
          },
        );
      },
    );
  }

  void _onPresetAmountSelected(String amount) {
    setState(() {
      _amountController.text = amount;
    });
  }

  @override
  void dispose() {
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF005CA9),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          'Buy Cryptocurrency',
          style: TextStyle(
            fontFamily: 'Roboto',
            fontWeight: FontWeight.w400,
            fontSize: 18,
            color: Colors.white,
            height: 1.0,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 100),
        child: ListView(
          children: [
            const SectionTitle(text: "You want to buy"),
            const SizedBox(height: 8),
            CoinDropdown(
              items: _coins,
              selectedSymbol: _selectedCoin,
              onChanged: (value) {
                if (value != null) {
                  setState(() {
                    _selectedCoin = value;
                  });
                }
              },
            ),
            const SizedBox(height: 4),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                  "Current balance: 0 $_selectedCoin = 0 $_selectedCurrency",
                  style: TextStyle(
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w400,
                    fontSize: 12,
                    color: Color(0xFF747474),
                    height: 1.0,
                  )),
            ),
            const SizedBox(height: 24),
            const SectionTitle(text: "Amount"),
            const SizedBox(height: 8),
            AmountInput(
              controller: _amountController,
              selectedCurrency: _selectedCurrency,
              onAmountChanged: (value) {},
              onCurrencyChanged: (value) {
                if (value != null) {
                  setState(() {
                    _selectedCurrency = value;
                  });
                }
              },
            ),
            const SizedBox(height: 16),
            PresetAmountButtons(
              presetAmounts: _presetAmounts,
              onAmountSelected: _onPresetAmountSelected,
            ),
            const SizedBox(height: 24),
            const SectionTitle(text: "Payment method"),
            const SizedBox(height: 8),
            PaymentMethodSelector(
              selectedPaymentMethod: _selectedPaymentMethod,
              paymentMethods: _paymentMethods,
              onTap: _showPaymentMethodSheet,
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 20),
        child: SizedBox(
          width: double.infinity,
          height: 50,
          child: ElevatedButton(
            onPressed: () {
              final amount = _amountController.text;
              final coin = _selectedCoin;
              final paymentMethod = _selectedPaymentMethod;
              // kekw
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Buying $amount $coin using $paymentMethod'),
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF005CA9),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: const Text(
              'Buy now',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
