import 'package:eto_pay/screens/kyc_verification_step2.dart';
import 'package:eto_pay/widgets/continue_button.dart';
import 'package:eto_pay/widgets/progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:eto_pay/providers/kyc_form_provider.dart';

class KycVerificationStep4Screen extends ConsumerStatefulWidget {
  const KycVerificationStep4Screen({super.key});

  @override
  ConsumerState<KycVerificationStep4Screen> createState() =>
      _KycVerificationStep4Screen();
}

class _KycVerificationStep4Screen
    extends ConsumerState<KycVerificationStep4Screen> {

  // Continue button state
  bool _continueButtonEnabled = false;
  void _setContinueButtonState(bool isValid) {
    setState(() {
      _continueButtonEnabled = isValid;
    });
  }

  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _emailController = TextEditingController();

  @override
  void initState() {
    super.initState();
    final current = ref.read(kycFormProvider);

    _firstNameController.text = current.firstName ?? "";
    _lastNameController.text = current.lastName ?? "";
    _emailController.text = current.email ?? "";

    _firstNameController.addListener(_validateInputs);
    _lastNameController.addListener(_validateInputs);
    _emailController.addListener(_validateInputs);
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();

    super.dispose();
  }

  void _validateInputs() {
    final firstName = _firstNameController.text.trim();
    final lastName = _lastNameController.text.trim();
    final email = _emailController.text.trim();

    // Update Kyc Form Provider data
    final current = ref.read(kycFormProvider);
    ref.read(kycFormProvider.notifier).state = current.copyWith(
      firstName: firstName,
      lastName: lastName,
      email: email
    );

    final isEnabled = firstName.isNotEmpty &&
        lastName.isNotEmpty &&
        _isValidEmail(email);

    _setContinueButtonState(isEnabled);
  }

  bool _isValidEmail(String email) {
    final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
    return emailRegex.hasMatch(email);
  }

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
                      style:
                          TextButton.styleFrom(foregroundColor: Colors.black),
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
                    StepProgressBar(currentStep: 4), 
                    const SizedBox(height: 20),
                    const Text(
                      "Step 4/4",
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
                    const SizedBox(height: 8),
                    _CustomInputField(
                      label: 'First name',
                      controller: _firstNameController,
                    ),
                    const SizedBox(height: 16),
                    _CustomInputField(
                      label: 'Last name',
                      controller: _lastNameController,
                    ),
                    const SizedBox(height: 16),
                    _CustomInputField(
                      label: 'Email ID',
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                    ),
                    const SizedBox(height: 24),
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
                    builder: (context) =>
                        KycVerificationStep2Screen(),
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

class _CustomInputField extends StatefulWidget {
  final String label;
  final TextEditingController controller;
  final TextInputType keyboardType;

  const _CustomInputField({
    required this.label,
    required this.controller,
    this.keyboardType = TextInputType.text,
  });

  @override
  State<_CustomInputField> createState() => _CustomInputFieldState();
}

class _CustomInputFieldState extends State<_CustomInputField> {
  bool _isFocused = false;

  @override
  Widget build(BuildContext context) {
    return Focus(
      onFocusChange: (focused) {
        setState(() {
          _isFocused = focused;
        });
      },
      child: TextField(
        controller: widget.controller,
        keyboardType: widget.keyboardType,
        style: const TextStyle(color: Colors.black),
        decoration: InputDecoration(
          hintText: widget.label,
          filled: true,
          fillColor: _isFocused ? Colors.white : const Color(0xFFF5F5F5),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(6),
            borderSide: const BorderSide(color: Color(0xFFF5F5F5)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(6),
            borderSide: const BorderSide(color: Color(0xFFF5F5F5)),
          ),
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        ),
      ),
    );
  }
}
