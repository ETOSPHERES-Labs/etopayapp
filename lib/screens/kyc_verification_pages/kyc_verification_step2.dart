import 'package:eto_pay/main.dart';
import 'package:eto_pay/screens/kyc_verification_pages/kyc_verification_step1.dart';
import 'package:eto_pay/screens/kyc_verification_pages/kyc_verification_step3.dart';
import 'package:eto_pay/widgets/blue_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:eto_pay/core/eu_countries.dart';
import 'package:eto_pay/providers/kyc_form_provider.dart';
import 'package:eto_pay/screens/kyc_verification_pages/kyc_verification_step2_driving_license.dart';
import 'package:eto_pay/screens/kyc_verification_pages/kyc_verification_step2_id_card.dart';
import 'package:eto_pay/screens/kyc_verification_pages/kyc_verification_step2_passport.dart';
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
                    Text(
                      "Step 2/4",
                      style: Theme.of(context).textTheme.displayMedium,
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
                        Text(
                          "2. ID Verification",
                          style: Theme.of(context).textTheme.titleSmall?.bold(),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      "Lorem ipsum dolor sit amet consectetur. Urna egestas ac pellentesque metus.",
                      style: Theme.of(context).textTheme.bodyMedium?.gray(),
                    ),
                    const SizedBox(height: 100),
                    Center(
                      child: SvgPicture.asset(
                        'assets/images/kyc_step_2.svg',
                        width: 200,
                      ),
                    ),
                    const SizedBox(height: 100),
                    Text(
                      "Select document issuing country",
                      style: Theme.of(context).textTheme.displayMedium,
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
                    Text("Select document type",
                        style: Theme.of(context).textTheme.displayMedium),
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
            BlueButton(
              text: 'Proceed',
              isActive: form.isStep2Valid,
              onPressed: form.isStep2Valid
                  ? () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                            builder: (_) => const KycVerificationStep3Screen()),
                      );
                    }
                  : () {},
            ),
            SizedBox(
              height: 8,
            )
          ],
        ),
      ),
    );
  }
}
