import 'package:flutter/material.dart';
import '../core/colors.dart';

class PinInputDisplay extends StatelessWidget {
  final String pin;
  final bool isFocused;
  final bool isAuthenticating;
  final bool showCursor;

  const PinInputDisplay({
    required this.pin,
    required this.isFocused,
    required this.isAuthenticating,
    required this.showCursor,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 212,
      height: 12,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: List.generate(6, (index) {
          final hasDigit = pin.length > index;
          final isCursor = isFocused &&
              !isAuthenticating &&
              pin.length == index &&
              showCursor &&
              pin.length < 6;

          if (hasDigit) {
            return Container(
              width: 16,
              height: 16,
              decoration: const BoxDecoration(
                color: AppColors.primary,
                shape: BoxShape.circle,
              ),
            );
          } else if (isCursor) {
            return Container(
              width: 16,
              height: 16,
              alignment: Alignment.center,
              child: Container(
                width: 2,
                height: 16,
                color: Colors.black,
              ),
            );
          } else {
            return Container(
              width: 16,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(2),
              ),
            );
          }
        }),
      ),
    );
  }
}
