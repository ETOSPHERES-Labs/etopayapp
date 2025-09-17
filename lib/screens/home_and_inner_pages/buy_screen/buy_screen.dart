import 'package:eto_pay/main.dart';
import 'package:eto_pay/models/payment_method_model.dart';
import 'package:eto_pay/providers/coin_provider.dart';
import 'package:eto_pay/providers/payment_method_provider.dart';
import 'package:eto_pay/screens/home_and_inner_pages/buy_screen/widgets/amount_input.dart';
import 'package:eto_pay/screens/home_and_inner_pages/buy_screen/widgets/coin_dropdown.dart';
import 'package:eto_pay/screens/home_and_inner_pages/buy_screen/widgets/kyc_modal.dart';
import 'package:eto_pay/screens/home_and_inner_pages/buy_screen/widgets/payment_method_bottom_sheet.dart';
import 'package:eto_pay/screens/home_and_inner_pages/buy_screen/widgets/payment_method_selector.dart';
import 'package:eto_pay/screens/home_and_inner_pages/buy_screen/widgets/preset_amount_buttons.dart';
import 'package:eto_pay/screens/home_and_inner_pages/buy_screen/widgets/section_title.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BuyScreen extends ConsumerStatefulWidget {
  const BuyScreen({super.key});

  @override
  ConsumerState<BuyScreen> createState() => _BuyScreenState();
}

class _BuyScreenState extends ConsumerState<BuyScreen> {
  final TextEditingController _amountController = TextEditingController();

  String _selectedCoin = 'SMR';
  String _selectedCurrency = 'EURO';
  String _selectedPaymentMethod = 'Sepa';

  final List<String> _presetAmounts = ['1,000', '2,500', '5,000', '10,000'];

  void _showPaymentMethodSheet(List<PaymentMethod> methods) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (_) {
        return PaymentMethodBottomSheet(
          paymentMethods: methods,
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
    final coinsAsync = ref.watch(coinsProvider);
    final paymentMethodsAsync = ref.watch(paymentMethodsProvider);

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
            coinsAsync.when(
              data: (coins) => CoinDropdown(
                items: coins,
                selectedSymbol: _selectedCoin,
                onChanged: (value) {
                  if (value != null) {
                    setState(() {
                      _selectedCoin = value;
                    });
                  }
                },
              ),
              loading: () => const CircularProgressIndicator(),
              error: (e, _) => Text('Error loading coins: $e'),
            ),
            const SizedBox(height: 4),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Current balance: 0 $_selectedCoin = 0 $_selectedCurrency",
                style: Theme.of(context).textTheme.labelSmall?.gray(),
              ),
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
            const SectionTitle(text: "Update payment method"),
            const SizedBox(height: 8),
            paymentMethodsAsync.when(
              data: (methods) => PaymentMethodSelector(
                selectedPaymentMethod: _selectedPaymentMethod,
                paymentMethods: methods,
                onTap: () => _showPaymentMethodSheet(methods),
              ),
              loading: () => const CircularProgressIndicator(),
              error: (e, _) => Text('Error loading payment methods: $e'),
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

              KycModal.show(context);

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
