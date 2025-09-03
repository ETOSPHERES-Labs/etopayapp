import 'package:eto_pay/models/payment_method_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class PaymentMethodSelector extends StatelessWidget {
  final String selectedPaymentMethod;
  final List<PaymentMethod> paymentMethods;
  final VoidCallback onTap;

  const PaymentMethodSelector({
    required this.selectedPaymentMethod,
    required this.paymentMethods,
    required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final method = paymentMethods.firstWhere((m) => m.label == selectedPaymentMethod);

    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
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
                  method.icon,
                  width: 24,
                  height: 24,
                ),
                const SizedBox(width: 8),
                Text(
                  selectedPaymentMethod,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
            Container(
              width: 32,
              height: 32,
              decoration: const BoxDecoration(
                color: Color(0xFF005CA9),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.arrow_forward, size: 18, color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
