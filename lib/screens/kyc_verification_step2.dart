import 'package:eto_pay/screens/kyc_verification_step1.dart';
import 'package:eto_pay/screens/kyc_verification_step3.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:eto_pay/core/eu_countries.dart';
import 'package:eto_pay/providers/kyc_form_provider.dart';
import 'package:eto_pay/screens/kyc_verification_step2_driving_license.dart';
import 'package:eto_pay/screens/kyc_verification_step2_id_card.dart';
import 'package:eto_pay/screens/kyc_verification_step2_passport.dart';
import 'package:eto_pay/widgets/continue_button.dart';
import 'package:eto_pay/widgets/country_dropdown.dart';
import 'package:eto_pay/widgets/progress_bar.dart';
import 'package:eto_pay/widgets/wide_button_with_icon_and_arrow.dart';

class KycVerificationStep2Screen extends ConsumerWidget {
  const KycVerificationStep2Screen({super.key});

  void _navigateToScreen(BuildContext context, Widget screen) {
    Navigator.of(context).push(MaterialPageRoute(builder: (_) => screen));
  }

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
                      style:
                          TextButton.styleFrom(foregroundColor: Colors.black),
                      onPressed: () => Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                              builder: (_) => KycVerificationStep1Screen())),
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
                    StepProgressBar(currentStep: 2),
                    const SizedBox(height: 20),
                    const Text(
                      "Step 2/4",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        SvgPicture.asset(
                          'assets/icons/icon_face_id.svg',
                          width: 20,
                          height: 20,
                        ),
                        const SizedBox(width: 8),
                        const Text(
                          "2. ID Verification",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      "Lorem ipsum dolor sit amet consectetur. Urna egestas ac pellentesque metus.",
                      style: TextStyle(
                        fontSize: 16,
                        color: Color(0xFF747474),
                      ),
                    ),
                    const SizedBox(height: 100),
                    Center(
                      child: SvgPicture.asset(
                        'assets/images/kyc_step_2.svg',
                        width: 200,
                      ),
                    ),
                    const SizedBox(height: 100),
                    const Text(
                      "Select document issuing country",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    const SizedBox(height: 8),
                    CountryDropdown(
                      countries: euCountries,
                      selectedCountry: form.idVerificationDocumentIssuer != null
                          ? findCountryByName(
                              form.idVerificationDocumentIssuer!)
                          : null,
                      onChanged: (country) {
                        if (country != null) {
                          notifier.updateIssuer(country.name);
                        }
                      },
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      "Select document type",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    const SizedBox(height: 8),
                    WideButtonWithIconAndArrow(
                      label: 'ID card',
                      icon: Icons.credit_card,
                      onPressed: () => _navigateToScreen(
                        context,
                        const KycVerificationStep2IdCardScreen(),
                      ),
                    ),
                    const SizedBox(height: 16),
                    WideButtonWithIconAndArrow(
                      label: 'Driving license',
                      icon: Icons.drive_eta,
                      onPressed: () => _navigateToScreen(
                        context,
                        const KycVerificationStep2DrivingLicenseScreen(),
                      ),
                    ),
                    const SizedBox(height: 16),
                    WideButtonWithIconAndArrow(
                      label: 'Passport',
                      icon: Icons.document_scanner,
                      onPressed: () => _navigateToScreen(
                        context,
                        const KycVerificationStep2PassportScreen(),
                      ),
                    ),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
            ContinueButtonWidget(
              isEnabled: form.isStep2Valid,
              text: 'Proceed',
              onPressed: form.isStep2Valid
                  ? () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                            builder: (_) => const KycVerificationStep3Screen()),
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
