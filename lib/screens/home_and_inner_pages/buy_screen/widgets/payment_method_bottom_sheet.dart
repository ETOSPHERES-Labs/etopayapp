import 'package:eto_pay/main.dart';
import 'package:eto_pay/models/payment_method_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class PaymentMethodBottomSheet extends StatelessWidget {
  final List<PaymentMethod> paymentMethods;
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
          Text(
            'Select payment method',
            style: Theme.of(context).textTheme.titleSmall?.black(),
          ),
          const SizedBox(height: 16),
          ...paymentMethods.map((method) {
            return GestureDetector(
              onTap: () {
                onSelect(method.label);
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
                          width: 40,
                          height: 40,
                          child: SvgPicture.asset(
                            method.icon,
                            width: 40,
                            height: 40,
                            fit: BoxFit.contain,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Text(method.label,
                            style: Theme.of(context)
                                .textTheme
                                .displayMedium
                                ?.black()),
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
                        Text(
                          'Instant.',
                          style:
                              Theme.of(context).textTheme.labelMedium?.gray(),
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
                        Text(
                          'Highest buy limit',
                          style:
                              Theme.of(context).textTheme.labelMedium?.gray(),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          }),
        ],
      ),
    );
  }
}
