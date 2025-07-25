import 'package:eto_pay/screens/kyc_verification_step1.dart';
import 'package:eto_pay/widgets/continue_button.dart';
import 'package:eto_pay/widgets/onboarding.dart';
import 'package:eto_pay/widgets/progress_bar.dart';
import 'package:flutter/material.dart';

class KycVerificationStep5Screen extends StatelessWidget {
  const KycVerificationStep5Screen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        top: true,
        bottom: true,
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextButton(
                      style: TextButton.styleFrom(
                        foregroundColor: Colors.black,
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.arrow_back),
                          SizedBox(width: 8),
                          Text('Back'),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    StepProgressBar(currentStep: 4, isComplete: true),
                    const SizedBox(height: 20),
                    const SizedBox(height: 20),
                    ImageCardListWidget(
                      svgAssetPath: 'assets/images/kyc_step5.svg',
                      subtitle:
                          'Your KYC details have been submitted. To view the status, please check your profile.',
                      contentBeforeFooter: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [],
                      ),
                    ),
                    Center(
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width * 0.8,
                        height: 50,
                        child: OutlinedButton(
                          style: OutlinedButton.styleFrom(
                            backgroundColor: const Color(0xFF005CA9),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(6),
                            ),
                            foregroundColor: Colors.white,
                            side: BorderSide.none,
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                          ),
                          onPressed: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) =>
                                    const KycVerificationStep1Screen(),
                              ),
                            );
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                'Go to home page',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(width: 8),
                              Container(
                                width: 24,
                                height: 24,
                                decoration: const BoxDecoration(
                                  color: Colors.white,
                                  shape: BoxShape.circle,
                                ),
                                child: const Icon(
                                  Icons.arrow_forward,
                                  color: Color(0xFF005CA9),
                                  size: 16,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
