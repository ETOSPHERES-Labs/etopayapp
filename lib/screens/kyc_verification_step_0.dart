import 'package:eto_pay/core/eu_countries.dart';
import 'package:eto_pay/screens/kyc_verification_step1.dart';
import 'package:eto_pay/widgets/continue_button.dart';
import 'package:eto_pay/widgets/country_dropdown.dart';
import 'package:eto_pay/widgets/onboarding.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:eto_pay/providers/kyc_form_provider.dart';

class KycVerificationStep0Screen extends ConsumerStatefulWidget {
  const KycVerificationStep0Screen({super.key});

  @override
  ConsumerState<KycVerificationStep0Screen> createState() =>
      _KycVerificationStep0Screen();
}

class _KycVerificationStep0Screen
    extends ConsumerState<KycVerificationStep0Screen> {
  // Kyc Form Provider data: nationality
  Country? _nationality;
  void _updateNationality(Country nationality) {
    setState(() {
      _nationality = nationality;
    });
    final current = ref.read(kycFormProvider);
    ref.read(kycFormProvider.notifier).state = current.copyWith(
      nationality: nationality.name,
    );
  }

  // Kyc Form Provider data: verification method
  String _verificationMethod = 'Postident';
  void _updateVerificationMethod(String verificationMethod) {
    setState(() {
      _verificationMethod = verificationMethod;
    });
    final current = ref.read(kycFormProvider);
    ref.read(kycFormProvider.notifier).state = current.copyWith(
      verificationMethod: _verificationMethod,
    );
  }

  // Continue button state
  bool _continueButtonEnabled = false;
  void _setContinueButtonState(bool isValid) {
    setState(() {
      _continueButtonEnabled = isValid;
    });
  }

  // Verification methods
  final List<Map<String, String>> _verificationMethods = [
    {'name': 'Postident', 'iconPath': 'assets/icons/icon_postident.svg'},
    {'name': 'Viviswap', 'iconPath': 'assets/icons/icon_viviswap.svg'},
  ];

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
                padding: const EdgeInsets.all(16.0),
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
                    ImageCardListWidget(
                      svgAssetPath: 'assets/images/verify_kyc.svg',
                      textData: 'Let’s verify your KYC',
                      subtitle:
                          'Lorem ipsum dolor sit amet consectetur. Placerat nisi id mattis volutpat sit justo.',
                      contentBeforeFooter: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Nationality",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(height: 8),
                          CountryDropdown(
                            countries: euCountries,
                            selectedCountry: _nationality,
                            onChanged: (value) {
                              _updateNationality(value!);
                              _setContinueButtonState(true);
                            },
                          ),
                          const SizedBox(height: 16),
                          const Text(
                            "Verification method",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Column(
                            children: _verificationMethods.map((method) {
                              final bool isSelected =
                                  _verificationMethod == method['name'];

                              return GestureDetector(
                                onTap: () {
                                  _updateVerificationMethod(method['name']!);
                                },
                                child: Container(
                                  margin: const EdgeInsets.only(bottom: 6),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16, vertical: 14),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border.all(
                                      color: isSelected
                                          ? const Color(0xFF005CA9)
                                          : const Color(0xFFF5F5F5),
                                      width: isSelected ? 2 : 1,
                                    ),
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  child: Row(
                                    children: [
                                      SvgPicture.asset(
                                        method['iconPath']!,
                                        width: 20,
                                        height: 20,
                                      ),
                                      const SizedBox(width: 12),
                                      Expanded(
                                        child: Text(
                                          method['name']!,
                                          style: const TextStyle(fontSize: 16),
                                        ),
                                      ),
                                      if (isSelected)
                                        Container(
                                          width: 24,
                                          height: 24,
                                          decoration: const BoxDecoration(
                                            color: Color(0xFF005CA9),
                                            shape: BoxShape.circle,
                                          ),
                                          child: const Icon(
                                            Icons.check,
                                            color: Colors.white,
                                            size: 16,
                                          ),
                                        ),
                                    ],
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            ContinueButtonWidget(
              isEnabled: _continueButtonEnabled,
              text: 'Proceed',
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => KycVerificationStep1Screen(),
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
