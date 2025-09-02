import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AmountInput extends StatelessWidget {
  final TextEditingController controller;
  final String selectedCurrency;
  final ValueChanged<String> onAmountChanged;
  final ValueChanged<String?> onCurrencyChanged;

  const AmountInput({
    required this.controller,
    required this.selectedCurrency,
    required this.onAmountChanged,
    required this.onCurrencyChanged,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 2,
          child: TextField(
            controller: controller,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            inputFormatters: [
              FilteringTextInputFormatter.allow(
                RegExp(r'^\d*\.?\d{0,2}'),
              ),
            ],
            decoration: InputDecoration(
              hintText: 'Enter amount',
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide:
                    const BorderSide(color: Color(0xFF005CA9), width: 2),
              ),
            ),
            onChanged: onAmountChanged,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          flex: 1,
          child: DropdownButtonFormField<String>(
            value: selectedCurrency,
            decoration: InputDecoration(
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            icon: const Icon(Icons.keyboard_arrow_down),
            onChanged: onCurrencyChanged,
            items: ['EURO', 'USD'].map((currency) {
              return DropdownMenuItem<String>(
                value: currency,
                child: Text(currency),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}
