import 'dart:io';
import 'dart:typed_data';
import 'package:eto_pay/core/eu_countries.dart';
import 'package:eto_pay/screens/kyc_verification_step3.dart';
import 'package:eto_pay/widgets/continue_button.dart';
import 'package:eto_pay/widgets/country_dropdown.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:eto_pay/widgets/dashed_container.dart';
import 'package:eto_pay/widgets/progress_bar.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:eto_pay/providers/kyc_form_provider.dart';

class KycVerificationStep2IdCardScreen extends ConsumerStatefulWidget {
  const KycVerificationStep2IdCardScreen({super.key});

  @override
  ConsumerState<KycVerificationStep2IdCardScreen> createState() =>
      _KycVerificationStep2IdCardScreen();
}

class _KycVerificationStep2IdCardScreen
    extends ConsumerState<KycVerificationStep2IdCardScreen> {
  bool _continueButtonEnabled = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _validateInputs() {
    // Update Kyc Form Provider data
    final current = ref.read(kycFormProvider);

    // todo: web or mobile? select correct bytes!!!!
    // btw. how to force "redraw" when we click "<- Back"?
    ref.read(kycFormProvider.notifier).state = current.copyWith(
      idVerificationDocumentIssuer: _selectedCountry!.name,
      idCardImageFileFront: _webImageBytesFront,
      idCardImageFileBack: _webImageBytesBack,
    );

    final isEnabled = 
        _selectedCountry != null &&
            _webImageBytesFront != null && _webImageBytesBack != null;

    _setContinueButtonState(isEnabled);
  }

  void _setContinueButtonState(bool isValid) {
    setState(() {
      _continueButtonEnabled = isValid;
    });
  }

  Country? _selectedCountry;

  // Front side image
  Uint8List? _webImageBytesFront;
  File? _localImageFileFront;

  // Back side image
  Uint8List? _webImageBytesBack;
  File? _localImageFileBack;

  // Max file size 5MB
  static const int maxFileSizeBytes = 5 * 1024 * 1024;

  Future<void> _pickImage({required bool isFront}) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['jpg', 'jpeg', 'png'],
      withData: kIsWeb,
    );

    if (result != null && result.files.isNotEmpty) {
      final file = result.files.first;

      // Check size limit if data is available (web) or from path (mobile)
      int? fileSize;
      if (kIsWeb) {
        fileSize = file.bytes?.lengthInBytes;
      } else {
        if (file.path != null) {
          final f = File(file.path!);
          fileSize = await f.length();
        }
      }

      if (fileSize != null && fileSize > maxFileSizeBytes) {
        _showSnackBar("File is too large. Max size is 5MB.");
        return;
      }

      if (kIsWeb) {
        setState(() {
          if (isFront) {
            _webImageBytesFront = file.bytes;
            _localImageFileFront = null;
          } else {
            _webImageBytesBack = file.bytes;
            _localImageFileBack = null;
          }
          _setContinueButtonState(true);
        });
      } else {
        if (file.path != null) {
          setState(() {
            if (isFront) {
              _localImageFileFront = File(file.path!);
              _webImageBytesFront = null;
            } else {
              _localImageFileBack = File(file.path!);
              _webImageBytesBack = null;
            }
            _setContinueButtonState(true);
          });
        }
      }
    }
  }

  void _removeImage({required bool isFront}) {
    setState(() {
      if (isFront) {
        _webImageBytesFront = null;
        _localImageFileFront = null;
      } else {
        _webImageBytesBack = null;
        _localImageFileBack = null;
      }
      _validateInputs();
    });
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  Widget _buildImagePreview({
    required bool isFront,
    required Uint8List? webImage,
    required File? localFile,
  }) {
    final imageExists = webImage != null || localFile != null;

    return GestureDetector(
      onTap: () => _pickImage(isFront: isFront),
      child: Stack(
        children: [
          DashedBorderContainer(
            backgroundColor:
                imageExists ? Color(0xFFFFFFFF) : const Color(0xFFF5F5F5),
            child: Center(
              child: imageExists
                  ? (kIsWeb
                      ? Image.memory(
                          webImage!,
                          width: 300,
                          height: 180,
                          fit: BoxFit.cover,
                        )
                      : Image.file(
                          localFile!,
                          width: 300,
                          height: 180,
                          fit: BoxFit.cover,
                        ))
                  : SvgPicture.asset(
                      'assets/icons/icon_upload.svg',
                      width: 80,
                      height: 80,
                    ),
            ),
          ),
          if (imageExists)
            Positioned(
              right: 4,
              top: 4,
              child: GestureDetector(
                onTap: () => _removeImage(isFront: isFront),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.5),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.close,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
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
                    StepProgressBar(currentStep: 2),
                    const SizedBox(height: 20),
                    const Text(
                      "Step 2/4",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
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
                    const SizedBox(height: 42),
                    const Text(
                      "Select document issues country",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      "Please upload your document clear images.",
                      style: TextStyle(
                        fontWeight: FontWeight.normal,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 8),
                    //
                    CountryDropdown( 
                      countries: euCountries,
                      selectedCountry: findCountryByName(ref.read(kycFormProvider).idVerificationDocumentIssuer!),
                      onChanged: (value) {
                        setState(() {
                          _selectedCountry = value;
                          _validateInputs();
                        });
                      },
                    ),
                    const SizedBox(height: 24),
                    Row(
                      children: [
                        SvgPicture.asset(
                          'assets/icons/icon_card_outline.svg',
                          width: 20,
                          height: 20,
                        ),
                        const SizedBox(width: 8),
                        const Text(
                          "ID card",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      "Please upload your document clear images.",
                      style: TextStyle(
                        fontWeight: FontWeight.normal,
                        color: Color(0xFF747474),
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      "Front side page",
                      style: TextStyle(
                        fontWeight: FontWeight.normal,
                        color: Color(0xFF000000),
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 8),
                    _buildImagePreview(
                      isFront: true,
                      webImage: _webImageBytesFront,
                      localFile: _localImageFileFront,
                    ),
                    const SizedBox(height: 24),
                    const Text(
                      "Back side page",
                      style: TextStyle(
                        fontWeight: FontWeight.normal,
                        color: Color(0xFF000000),
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 8),
                    _buildImagePreview(
                      isFront: false,
                      webImage: _webImageBytesBack,
                      localFile: _localImageFileBack,
                    ),
                    const SizedBox(height: 100),
                  ],
                ),
              ),
            ),
            ContinueButtonWidget(
              isEnabled: _continueButtonEnabled,
              text: 'Next',
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) =>
                        KycVerificationStep3Screen(),
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
