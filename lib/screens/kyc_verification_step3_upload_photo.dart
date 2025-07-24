import 'package:eto_pay/providers/kyc_form_provider.dart';
import 'package:eto_pay/screens/kyc_verification_step4.dart';
import 'package:eto_pay/widgets/continue_button.dart';
import 'package:eto_pay/widgets/image_upload_card.dart';
import 'package:eto_pay/widgets/progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';

class KycVerificationStep3UploadPhotoScreen extends ConsumerWidget {
  const KycVerificationStep3UploadPhotoScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final form = ref.watch(kycFormProvider);
    final notifier = ref.read(kycFormProvider.notifier);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextButton(
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
                    const SizedBox(height: 20),
                    StepProgressBar(currentStep: 3),
                    const SizedBox(height: 20),
                    const Text("Step 3/4", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        SvgPicture.asset('assets/icons/icon_selfie.svg', width: 20, height: 20),
                        const SizedBox(width: 8),
                        const Text("3. Selfie or photo verification", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
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
                    const SizedBox(height: 24),
                    Row(
                      children: const [
                        Icon(
                          Icons.photo_outlined,
                          size: 20,
                        ),
                        SizedBox(width: 8),
                        Text(
                          "Upload your valid photo",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    ImageUploadCard(
                      label: "Please select and upload a photo from your gallery.",
                      initialWebImage: form.selfie?.web,
                      initialLocalImage: form.selfie?.phone,
                      onImageSelected: (bytes, file) =>
                          notifier.updateSelfie(webBytes: bytes, phoneFile: file),
                    ),
                    const SizedBox(height: 100),
                  ],
                ),
              ),
            ),
            ContinueButtonWidget(
              isEnabled: form.isSelfieValid,
              text: 'Next',
              onPressed: form.isSelfieValid
                  ? () {
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (_) => const KycVerificationStep4Screen()),
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
