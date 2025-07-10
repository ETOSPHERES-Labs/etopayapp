import 'dart:ui';
import 'package:eto_pay/view_models/recovery_phrase_view_model.dart';
import 'package:eto_pay/widgets/conditional_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:eto_pay/screens/recovery_phrase_verification_screen.dart';
import 'package:eto_pay/core/colors.dart';

class RecoveryPhraseView extends StatelessWidget {
  const RecoveryPhraseView({super.key});

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<RecoveryPhraseViewModel>(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Text(
          'Recovery phrase',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          'Please download the recovery kit and write down the words in the exact order shown below',
          style: TextStyle(color: AppColors.subtext),
        ),
        const SizedBox(height: 24),
        Expanded(
          child: Stack(
            alignment: Alignment.center,
            children: [
              GridView.builder(
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 180,
                  childAspectRatio: 3,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
                ),
                itemCount: model.recoveryPhrase.length,
                itemBuilder: (context, index) {
                  return Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withAlpha(128),
                          spreadRadius: 1,
                          blurRadius: 3,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Center(
                      child: Text(
                        '${index + 1}. ${model.recoveryPhrase[index]}',
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  );
                },
              ),
              if (!model.isRevealed)
                Positioned.fill(
                  child: ClipRect(
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                      child: Container(
                        color: Colors.transparent,
                      ),
                    ),
                  ),
                ),
              if (!model.isRevealed)
                ConditionalButton(
                  isActive: true,
                  onPressed: () => model.reveal(),
                  text: 'Reveal recovery phrase',
                ),
            ],
          ),
        ),
        const SizedBox(height: 24),
        const Text(
          'Keep these words confidential, secure and never share it with anyone',
          style:
              TextStyle(fontWeight: FontWeight.bold, color: AppColors.subtext),
        ),
        const SizedBox(height: 8),
        const Text(
          'A written backup is important because computer failures can cause data corruption',
          style: TextStyle(color: AppColors.subtext),
        ),
        const SizedBox(height: 24),
        ConditionalButton(
          isActive: true,
          onPressed: () {
            // TODO: Implement PDF download
          },
          text: 'Save Recovery kit template',
        ),
        const SizedBox(height: 16),
        ConditionalButton(
          isActive: model.isRevealed,
          onPressed: () {
            if (model.isRevealed) {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => RecoveryPhraseVerificationScreen(
                    recoveryPhrase: model.recoveryPhrase,
                  ),
                ),
              );
            }
          },
          text: 'Continue',
        ),
      ],
    );
  }
}
