import 'dart:typed_data';
import 'package:eto_pay/core/theme.dart';
import 'package:flutter/material.dart';
import 'package:eto_pay/core/text_styles.dart';
import 'package:eto_pay/widgets/conditional_button.single.dart';
import 'package:flutter_svg/flutter_svg.dart';

class UploadRecoveryFileImportFileScreen extends StatefulWidget {
  final Uint8List fileBytes;
  final String fileName;
  final bool isPin;
  const UploadRecoveryFileImportFileScreen({super.key, required this.fileBytes, required this.fileName, 
    this.isPin = false,});

  @override
  State<UploadRecoveryFileImportFileScreen> createState() =>
      _UploadRecoveryFileImportFileScreen();
}

class _UploadRecoveryFileImportFileScreen
    extends State<UploadRecoveryFileImportFileScreen> {
  static const double _continueButtonHeight = 64;
  bool _isContinueButtonEnabled = false;
  final _pinController = TextEditingController();
  bool _obscureState = true;

  void _setContinueButtonState(bool isValid) {
    setState(() {
      _isContinueButtonEnabled = isValid;
    });
  }

  @override
  void initState() {
    super.initState();
    _pinController.addListener(_updateContinueButton);
  }

  void _updateContinueButton() {
    _setContinueButtonState(_pinController.text.isNotEmpty);
  }

  @override
  void dispose() {
    _pinController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Column(
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
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: const [
                        Icon(Icons.arrow_back),
                        SizedBox(width: 8),
                        Text('Back'),
                      ],
                    ),
                  ),
                  const SizedBox(height: 18),
                  Center(
                    child: SvgPicture.asset(
                      'images/upload_your_backup_file_import_file.svg',
                      height: 310,
                      width: 300,
                    ),
                  ),
                  const SizedBox(height: 42),
                  Text(
                    'Import share',
                    style: AppTextStyles.boldCentered,
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Please enter your backup password.',
                    style: TextStyle(color: Color(0xFF000000)),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'This is the password you set when you first created your backup.',
                    style: TextStyle(color: Color(0xFF000000)),
                  ),
                  const SizedBox(height: 24),
                  TextField(
                    controller: _pinController,
                    obscureText: _obscureState,
                    keyboardType: widget.isPin
                        ? TextInputType.number
                        : TextInputType.text,
                    maxLength: widget.isPin ? 6 : null,
                    decoration: InputDecoration(
                      labelText: widget.isPin ? 'Enter PIN' : 'Enter password',
                      filled: true,
                      fillColor: AppTheme.inputFieldBackground,
                      enabledBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: AppTheme.inputFieldBackground),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: AppTheme.inputFieldBackground),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      prefixIcon: const Icon(Icons.lock_outline, size: 20),
                      suffixIcon: IconButton(
                        icon: Icon(_obscureState
                            ? Icons.visibility_off
                            : Icons.visibility),
                        onPressed: () => setState(() => _obscureState = !_obscureState),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          Container(
            height: _continueButtonHeight,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            color: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ConditionalSingleButton(
                  isActive: _isContinueButtonEnabled,
                  onPressed: () {},
                  text: 'Continue',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
