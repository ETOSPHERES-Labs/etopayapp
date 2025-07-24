import 'package:eto_pay/screens/kyc_verification_step2.dart';
import 'package:eto_pay/widgets/continue_button.dart';
import 'package:eto_pay/widgets/custom_wide_input_field.dart';
import 'package:eto_pay/widgets/progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:eto_pay/providers/kyc_form_provider.dart';

class KycVerificationStep4Screen extends ConsumerWidget {
  const KycVerificationStep4Screen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final form = ref.watch(kycFormProvider);
    final notifier = ref.read(kycFormProvider.notifier);

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
                    StepProgressBar(currentStep: 4),
                    const SizedBox(height: 20),
                    const Text("Step 4/4", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        SvgPicture.asset(
                          'assets/icons/icon_presonal_information.svg',
                          width: 20,
                          height: 20,
                        ),
                        const SizedBox(width: 8),
                        const Text(
                          "1. Personal information",
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      "Lorem ipsum dolor sit amet consectetur. Urna egestas ac pellentesque metus.",
                      style: TextStyle(fontSize: 16, color: Color(0xFF747474)),
                    ),
                    const SizedBox(height: 16),
                    CustomInputField(
                      label: "First name",
                      value: form.firstName ?? "",
                      onChanged: notifier.updateFirstName,
                    ),
                    const SizedBox(height: 16),
                    CustomInputField(
                      label: "Last name",
                      value: form.lastName ?? "",
                      onChanged: notifier.updateLastName,
                    ),
                    const SizedBox(height: 16),
                    CustomInputField(
                      label: "Email",
                      value: form.email ?? "",
                      keyboardType: TextInputType.emailAddress,
                      onChanged: notifier.updateEmail,
                    ),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
            ContinueButtonWidget(
              isEnabled: form.isStep4Valid,
              text: 'Proceed',
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => const KycVerificationStep2Screen(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
