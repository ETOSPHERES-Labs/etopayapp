import 'dart:ui';
import 'package:eto_pay/view_models/recovery_phrase_verification_view_model.dart';
import 'package:eto_pay/widgets/conditional_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:eto_pay/core/colors.dart';
import 'package:eto_pay/widgets/onboarding.dart';

class RecoveryPhraseVerificationScreen extends StatelessWidget {
  final List<String> recoveryPhrase;
  const RecoveryPhraseVerificationScreen(
      {super.key, required this.recoveryPhrase});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ChangeNotifierProvider(
          create: (_) => RecoveryPhraseVerificationViewModel(recoveryPhrase),
          child: const _VerificationView(),
        ),
      ),
    );
  }
}

class _VerificationView extends StatelessWidget {
  const _VerificationView();

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<RecoveryPhraseVerificationViewModel>(context);
    final currentOptions = model.options[model.currentIndex];
    final selected = model.userAnswers[model.currentIndex];

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: TextButton(
              style: TextButton.styleFrom(foregroundColor: Colors.black),
              onPressed: () => Navigator.of(context).pop(),
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.arrow_back),
                  SizedBox(width: 8),
                  Text('Back'),
                ],
              ),
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Verify recovery phrase',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          const Text(
            "Let's check if you have written down the recovery phrase correctly!",
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
                    final isPastOrCurrent = index <= model.currentIndex;
                    final selectedIdx = model.userAnswers[index];
                    final showWord = isPastOrCurrent && selectedIdx != null;
                    return Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 1,
                            blurRadius: 3,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Center(
                        child: showWord
                            ? Text(
                                model.options[index][selectedIdx],
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  fontWeight: FontWeight.w500,
                                ),
                              )
                            : isPastOrCurrent
                                ? Text(
                                    '#${index + 1}',
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w500,
                                    ),
                                  )
                                : ClipRect(
                                    child: BackdropFilter(
                                      filter: ImageFilter.blur(
                                          sigmaX: 10, sigmaY: 10),
                                      child: Container(
                                        color: Colors.transparent,
                                      ),
                                    ),
                                  ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          Text(
            '#word${model.currentIndex + 1}',
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
          const SizedBox(height: 8),
          ...List.generate(
              currentOptions.length,
              (i) => RadioListTile<int>(
                    value: i,
                    groupValue: selected,
                    onChanged: (v) => model.selectAnswer(v!),
                    title: Text(currentOptions[i]),
                  )),
          const SizedBox(height: 16),
          ConditionalButton(
            isActive: model.canProceed,
            onPressed: () {
              if (!model.canProceed) return;
              if (model.isLast) {
                if (model.isVerified) {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (context) => const _VerificationSuccessScreen(),
                    ),
                  );
                } else {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text('Incorrect'),
                      content: const Text(
                          'Some answers are incorrect. Please try again.'),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                            model.reset();
                          },
                          child: const Text('Retry'),
                        ),
                      ],
                    ),
                  );
                }
              } else {
                model.next();
              }
            },
            text: model.isLast ? 'Finish' : 'Next',
          ),
        ],
      ),
    );
  }
}

class _VerificationSuccessScreen extends StatelessWidget {
  const _VerificationSuccessScreen();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: ImageCardListWidget(
            svgAssetPath: 'assets/images/phrase_verification.svg',
            textData: 'Recovery phrase verified',
            subtitle: 'Ensure it remains private and is stored securely',
            cards: const [],
            footer: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(height: 32),
                ConditionalButton(
                  isActive: true,
                  onPressed: () =>
                      Navigator.of(context).popUntil((route) => route.isFirst),
                  text: 'Continue',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
