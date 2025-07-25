import 'package:eto_pay/providers/kyc_form_provider.dart';
import 'package:eto_pay/screens/kyc_verification_step3_upload_photo.dart';
import 'package:eto_pay/screens/kyc_verification_step4.dart';
import 'package:eto_pay/widgets/continue_button.dart';
import 'package:eto_pay/widgets/progress_bar.dart';
import 'package:eto_pay/widgets/wide_button_with_icon_and_arrow.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class KycVerificationStep3Screen extends ConsumerWidget {
  const KycVerificationStep3Screen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final form = ref.watch(kycFormProvider);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        top: true,
        bottom: true,
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextButton(
                      style:
                          TextButton.styleFrom(foregroundColor: Colors.black),
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
                    const SizedBox(height: 20),
                    StepProgressBar(currentStep: 3),
                    const SizedBox(height: 20),
                    const Text(
                      "Step 3/4",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        SvgPicture.asset(
                          'assets/icons/icon_selfie.svg',
                          width: 20,
                          height: 20,
                        ),
                        const SizedBox(width: 8),
                        const Text(
                          "3.Selfie or photo verification",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      "Lorem ipsum dolor sit amet consectetur. Urna egestas ac pellentesque metus.",
                      style: TextStyle(
                        fontWeight: FontWeight.normal,
                        fontSize: 16,
                        color: Color(0xFF747474),
                      ),
                    ),
                    const SizedBox(height: 100),
                    Center(
                      child: SvgPicture.asset(
                        'assets/images/kyc_step_3.svg',
                        width: 200,
                      ),
                    ),
                    const SizedBox(height: 100),
                    WideButtonWithIconAndArrow(
                      label: 'Upload your valid photo',
                      icon: Icons.photo_outlined,
                      onPressed: () => Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) =>
                              KycVerificationStep3UploadPhotoScreen(),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    WideButtonWithIconAndArrow(
                      label: 'Take a selfie of yourself',
                      icon: Icons.add_a_photo_outlined,
                      onPressed: () {
                        // todo
                      },
                    ),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
            ContinueButtonWidget(
              isEnabled: form.isStep3Valid,
              text: 'Proceed',
              onPressed: form.isStep3Valid
                  ? () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                            builder: (_) => const KycVerificationStep4Screen()),
                      );
                    }
                  : () {},
            ),
          ],
        ),
      ),
    );
  }
}
