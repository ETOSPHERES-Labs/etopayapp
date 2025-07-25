import 'dart:io';

import 'package:eto_pay/core/eu_countries.dart';
import 'package:eto_pay/providers/kyc_form_provider.dart';
import 'package:eto_pay/screens/kyc_verification_step2.dart';
import 'package:eto_pay/widgets/continue_button.dart';
import 'package:eto_pay/widgets/country_dropdown.dart';
import 'package:eto_pay/widgets/image_upload_card.dart';
import 'package:eto_pay/widgets/progress_bar.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';

class KycVerificationStep2PassportScreen extends ConsumerWidget {
  const KycVerificationStep2PassportScreen({super.key});

  void _updateIssuer(WidgetRef ref, String countryName) {
    final notifier = ref.read(kycFormProvider.notifier);
    notifier.updateIssuer(countryName);
  }

  void _updateDocumentImage({
    required WidgetRef ref,
    required bool isFront,
    required Uint8List? webBytes,
    required File? phoneFile,
  }) {
    final notifier = ref.read(kycFormProvider.notifier);
    notifier.updatePassportImage(
      isFront: isFront,
      webBytes: webBytes,
      phoneFile: phoneFile,
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final form = ref.watch(kycFormProvider);

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
                    StepProgressBar(currentStep: 2),
                    const SizedBox(height: 20),
                    const Text(
                      "Step 2/4",
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        SvgPicture.asset('assets/icons/icon_face_id.svg', width: 20, height: 20),
                        const SizedBox(width: 8),
                        const Text(
                          "2. ID Verification",
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      "Lorem ipsum dolor sit amet consectetur. Urna egestas ac pellentesque metus.",
                      style: TextStyle(color: Color(0xFF747474), fontSize: 16),
                    ),
                    const SizedBox(height: 42),
                    const Text(
                      "Select document issuer country",
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    const SizedBox(height: 8),
                    CountryDropdown(
                      countries: euCountries,
                      selectedCountry: form.idVerificationDocumentIssuer != null
                          ? findCountryByName(form.idVerificationDocumentIssuer!)
                          : null,
                      onChanged: (value) {
                        if (value != null) {
                          _updateIssuer(ref, value.name);
                        }
                      },
                    ),
                    const SizedBox(height: 24),
                    const Text(
                      "Passport",
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      "Please upload clear images of both sides of your passport",
                      style: TextStyle(color: Color(0xFF747474), fontSize: 16),
                    ),
                    const SizedBox(height: 16),
                    ImageUploadCard(
                      label: "Front side",
                      initialWebImage: form.passport?.front?.web,
                      initialLocalImage: form.passport?.front?.phone,
                      onImageSelected: (bytes, file) => _updateDocumentImage(
                        ref: ref,
                        isFront: true,
                        webBytes: bytes,
                        phoneFile: file,
                      ),
                    ),
                    const SizedBox(height: 24),
                    ImageUploadCard(
                      label: "Back side",
                      initialWebImage: form.passport?.back?.web,
                      initialLocalImage: form.passport?.back?.phone,
                      onImageSelected: (bytes, file) => _updateDocumentImage(
                        ref: ref,
                        isFront: false,
                        webBytes: bytes,
                        phoneFile: file,
                      ),
                    ),
                    const SizedBox(height: 100),
                  ],
                ),
              ),
            ),
            ContinueButtonWidget(
              isEnabled: form.isStep2PassportValid,
              text: 'Submit',
              onPressed: form.isStep2PassportValid
                  ? () {
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (_) => const KycVerificationStep2Screen()),
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
