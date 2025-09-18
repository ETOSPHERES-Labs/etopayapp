import 'package:eto_pay/widgets/blue_button.dart';
import 'package:flutter/material.dart';

class BlueButtonStyle {
  final Color activeColor;
  final Color inactiveColor;
  final Color foregroundColor;
  final Color disabledForegroundColor;
  final TextStyle? textStyle;

  const BlueButtonStyle({
    this.activeColor = const Color(0xFF005CA9),
    this.inactiveColor = const Color(0x80005CA9),
    this.foregroundColor = Colors.white,
    this.disabledForegroundColor = Colors.white,
    this.textStyle,
  });
}

class BlueButtonData {
  final String text;
  final VoidCallback onPressed;
  final bool isActive;
  final Widget? icon;
  final BlueButtonStyle? style;

  const BlueButtonData({
    required this.text,
    required this.onPressed,
    this.isActive = true,
    this.icon,
    this.style,
  });
}

class BlueDoubleButton extends StatelessWidget {
  final BlueButtonData leftButton;
  final BlueButtonData rightButton;

  const BlueDoubleButton({
    super.key,
    required this.leftButton,
    required this.rightButton,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: BlueButton(
            text: leftButton.text,
            onPressed: leftButton.onPressed,
            isActive: leftButton.isActive,
            icon: leftButton.icon,
            padding: EdgeInsets.zero,
            activeColor:
                leftButton.style?.activeColor ?? const Color(0xFF005CA9),
            inactiveColor:
                leftButton.style?.inactiveColor ?? const Color(0x80005CA9),
            foregroundColor: leftButton.style?.foregroundColor ?? Colors.white,
            disabledForegroundColor:
                leftButton.style?.disabledForegroundColor ?? Colors.white,
            textStyle: leftButton.style?.textStyle,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: BlueButton(
            text: rightButton.text,
            onPressed: rightButton.onPressed,
            isActive: rightButton.isActive,
            icon: rightButton.icon,
            padding: EdgeInsets.zero,
            activeColor:
                rightButton.style?.activeColor ?? const Color(0xFF005CA9),
            inactiveColor:
                rightButton.style?.inactiveColor ?? const Color(0x80005CA9),
            foregroundColor: rightButton.style?.foregroundColor ?? Colors.white,
            disabledForegroundColor:
                rightButton.style?.disabledForegroundColor ?? Colors.white,
            textStyle: rightButton.style?.textStyle,
          ),
        ),
      ],
    );
  }
}
