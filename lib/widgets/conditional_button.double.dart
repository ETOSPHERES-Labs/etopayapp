import 'package:eto_pay/widgets/conditional_button.single.dart';
import 'package:flutter/material.dart';

class ContinueButtonDoubleWidget extends StatelessWidget {
  final bool isLeftEnabled;
  final bool isRightEnabled;
  final String leftText;
  final String rightText;
  final VoidCallback onLeftPressed;
  final VoidCallback onRightPressed;

  const ContinueButtonDoubleWidget({
    super.key,
    required this.isLeftEnabled,
    required this.isRightEnabled,
    required this.leftText,
    required this.rightText,
    required this.onLeftPressed,
    required this.onRightPressed,
  });

  @override
  Widget build(BuildContext context) {
    const double buttonHeight = 64;

    return Container(
      height: buttonHeight,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      color: Colors.white,
      child: Row(
        children: [
          Expanded(
            child: ConditionalSingleButton(
              isActive: isLeftEnabled,
              onPressed: onLeftPressed,
              text: leftText,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: ConditionalSingleButton(
              isActive: isRightEnabled,
              onPressed: onRightPressed,
              text: rightText,
            ),
          ),
        ],
      ),
    );
  }
}
