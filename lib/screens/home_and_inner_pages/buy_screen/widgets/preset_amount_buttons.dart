import 'package:flutter/material.dart';

class PresetAmountButtons extends StatelessWidget {
  final List<String> presetAmounts;
  final ValueChanged<String> onAmountSelected;

  const PresetAmountButtons({
    required this.presetAmounts,
    required this.onAmountSelected,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: presetAmounts.map((amount) {
        return Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 18),
                backgroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                  side: const BorderSide(color: Color(0xFF005CA9), width: 1),
                ),
              ),
              onPressed: () => onAmountSelected(amount.replaceAll(',', '')),
              child: Text(
                amount,
                style: const TextStyle(color: Colors.black),
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}
