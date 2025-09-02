import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class PaymentMethodBottomSheet extends StatelessWidget {
  final List<Map<String, String>> paymentMethods;
  final ValueChanged<String> onSelect;

  const PaymentMethodBottomSheet({
    required this.paymentMethods,
    required this.onSelect,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            'Select payment method',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 16),
          ...paymentMethods.map((method) {
            return GestureDetector(
              onTap: () {
                onSelect(method['label']!);
                Navigator.pop(context);
              },
              child: Container(
                margin: const EdgeInsets.only(bottom: 12),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color(0xFFF0F0F0),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 38,
                          height: 38,
                          child: SvgPicture.asset(
                            method['icon']!,
                            width: 38,
                            height: 38,
                            fit: BoxFit.contain,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Text(
                          method['label']!,
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        SvgPicture.asset(
                          'assets/icons/icon_time.svg',
                          width: 16,
                          height: 16,
                          colorFilter: const ColorFilter.mode(
                              Color(0xFF747474), BlendMode.srcIn),
                        ),
                        const SizedBox(width: 6),
                        const Text(
                          'Instant.',
                          style: TextStyle(
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.w400,
                            fontSize: 11,
                            color: Color(0xFF747474),
                          ),
                        ),
                        const SizedBox(width: 3),
                        SvgPicture.asset(
                          'assets/icons/icon_euro.svg',
                          width: 11,
                          height: 11,
                          colorFilter: const ColorFilter.mode(
                              Color(0xFF747474), BlendMode.srcIn),
                        ),
                        const SizedBox(width: 6),
                        const Text(
                          'Highest buy limit',
                          style: TextStyle(
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.w400,
                            fontSize: 11,
                            color: Color(0xFF747474),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
        ],
      ),
    );
  }
}
