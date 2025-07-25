import 'package:eto_pay/providers/kyc_form_provider.dart';
import 'package:eto_pay/screens/kyc_verification_step2.dart';
import 'package:eto_pay/widgets/continue_button.dart';
import 'package:eto_pay/widgets/custom_wide_input_field.dart';
import 'package:eto_pay/widgets/progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class KycVerificationStep1Screen extends ConsumerWidget {
  const KycVerificationStep1Screen({super.key});

  void _launchTermsUrl() async {
    const url = 'https://viviswap.com/terms';
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }

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
                    StepProgressBar(currentStep: 1),
                    const SizedBox(height: 20),
                    const Text(
                      "Step 1/4",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
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
                        'assets/images/kyc_step1.svg',
                        width: 200,
                      ),
                    ),
                    const SizedBox(height: 100),
                    CustomInputField(
                      label: 'First name',
                      value: form.firstName ?? "",
                      onChanged: notifier.updateFirstName,
                    ),
                    const SizedBox(height: 16),
                    CustomInputField(
                      label: 'Last name',
                      value: form.lastName ?? "",
                      onChanged: notifier.updateLastName,
                    ),
                    const SizedBox(height: 16),
                    CustomInputField(
                      label: 'Email',
                      value: form.email ?? "",
                      onChanged: notifier.updateEmail,
                      keyboardType: TextInputType.emailAddress,
                    ),
                    const SizedBox(height: 24),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Checkbox(
                          value: form.termsAccepted ?? false,
                          onChanged: (value) =>
                              notifier.updateTermsAccepted(value ?? false),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(top: 2.0),
                            child: RichText(
                              textAlign: TextAlign.left,
                              text: TextSpan(
                                style: const TextStyle(
                                  fontSize: 15,
                                  height: 1.5,
                                  color: Colors.black,
                                ),
                                children: [
                                  const TextSpan(
                                      text: 'I have read & accept the '),
                                  TextSpan(
                                    text: 'Terms of Service',
                                    style: const TextStyle(
                                      color: Color(0xFF005CA9),
                                      decoration: TextDecoration.underline,
                                    ),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = _launchTermsUrl,
                                  ),
                                  const TextSpan(text: ' for viviswap'),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            ContinueButtonWidget(
              isEnabled: form.isStep1Valid,
              text: 'Proceed',
              onPressed: form.isStep1Valid
                  ? () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) =>
                              const KycVerificationStep2Screen(),
                        ),
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
