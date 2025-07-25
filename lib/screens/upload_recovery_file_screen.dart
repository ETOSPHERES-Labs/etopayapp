import 'dart:typed_data';
import 'package:eto_pay/screens/upload_recovery_file_import_file_screen.dart';
import 'package:eto_pay/widgets/dashed_container.dart';
import 'package:flutter/material.dart';
import 'package:eto_pay/core/colors.dart';
import 'package:eto_pay/core/text_styles.dart';
import 'package:eto_pay/widgets/conditional_button.single.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:file_picker/file_picker.dart';

class UploadRecoveryFileScreen extends StatefulWidget {
  const UploadRecoveryFileScreen({super.key, required this.network});
  final String network;

  @override
  State<UploadRecoveryFileScreen> createState() => _UploadRecoveryFileScreen();
}

class _UploadRecoveryFileScreen extends State<UploadRecoveryFileScreen> {
  static const double _continueButtonHeight = 64;
  bool _isContinueButtonEnabled = false;
  String _fileName = "";
  Uint8List _fileBytes = Uint8List(0);

  void _setContinueButtonState(bool isValid) {
    setState(() {
      _isContinueButtonEnabled = isValid;
    });
  }

  void _setFileName(String fileName) {
    setState(() {
      _fileName = fileName;
    });
  }

  void _setFileBytes(Uint8List? fileBytes) {
    if (fileBytes == null || fileBytes.isEmpty) {
      setState(() {
        _isContinueButtonEnabled = false;
      });
    } else {
      setState(() {
        _fileBytes = fileBytes;
        _isContinueButtonEnabled = true;
      });
    }
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
                  Text(
                    'Upload your backup file',
                    style: AppTextStyles.boldCentered,
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Please upload your backup file to restore your profile.',
                    style: TextStyle(color: AppColors.subtext),
                  ),
                  const SizedBox(height: 24),
                  if (_fileName.isEmpty)
                    Container(
                      width: double.infinity,
                      height: 300,
                      color: Color(0xFFF5F5F5),
                      child: Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SvgPicture.asset(
                              'images/drag_and_drop_icon.svg',
                              height: 100,
                              width: 100,
                            ),
                            const SizedBox(height: 16),
                            const Text(
                              'Upload share',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              "pdf or .stronghold file",
                              style: const TextStyle(
                                  fontSize: 16, color: Color(0xFF747474)),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 26),
                            ConditionalSingleButton(
                              isActive: true,
                              onPressed: () async {
                                FilePickerResult? result = await FilePicker
                                    .platform
                                    .pickFiles(type: FileType.any);
                                if (result != null) {
                                  final Uint8List? fileBytes =
                                      result.files.first.bytes;
                                  final String fileName =
                                      result.files.first.name;
                                  setState(() {
                                    _setContinueButtonState(true);
                                    _setFileName(fileName);
                                    _setFileBytes(fileBytes);
                                  });
                                } else {
                                  setState(() {
                                    _setContinueButtonState(false);
                                    _setFileName("");
                                  });
                                }
                              },
                              text: 'Select file',
                            ),
                          ],
                        ),
                      ),
                    )
                  else
                    DashedBorderContainer(
                      child: Center(
                        child: Text(_fileName),
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
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) =>
                          UploadRecoveryFileImportFileScreen(fileBytes: _fileBytes, fileName: _fileName,),
                    ));
                  },
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
