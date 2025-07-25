import 'package:flutter/material.dart';

class StepProgressBar extends StatelessWidget {
  final int currentStep;
  final bool isComplete;

  const StepProgressBar({
    super.key,
    required this.currentStep,
    this.isComplete = false,
  });

  final int totalSteps = 4;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(totalSteps * 2 - 1, (index) {
        if (index.isEven) {
          int stepIndex = index ~/ 2 + 1;

          bool isCompleted = isComplete || stepIndex < currentStep;
          bool isCurrent = stepIndex == currentStep;

          Color bgColor = isCompleted
              ? const Color(0xFF028032)
              : isCurrent
                  ? const Color(0xFF005CA9)
                  : const Color(0xFFE6EFF7);

          return Expanded(
            flex: 2,
            child: CircleAvatar(
              radius: 16,
              backgroundColor: bgColor,
              child: isCompleted
                  ? const Icon(Icons.check, color: Colors.white, size: 18)
                  : Text(
                      '$stepIndex',
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
            ),
          );
        } else {
          int stepLineIndex = (index - 1) ~/ 2 + 1;
          bool isCompleted = isComplete || stepLineIndex < currentStep;

          return Expanded(
            flex: 3,
            child: Container(
              height: 4,
              color: isCompleted
                  ? const Color(0xFF028032)
                  : const Color(0xFFE6EFF7),
            ),
          );
        }
      }),
    );
  }
}
