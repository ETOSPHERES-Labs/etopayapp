import 'dart:io';
import 'dart:typed_data';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:eto_pay/widgets/dashed_container.dart';

class ImageUploadCard extends StatefulWidget {
  final String label;
  final Uint8List? initialWebImage;
  final File? initialLocalImage;
  final Function(Uint8List? webBytes, File? phoneFile) onImageSelected;
  final bool isFront;

  const ImageUploadCard({
    super.key,
    required this.label,
    required this.onImageSelected,
    this.initialWebImage,
    this.initialLocalImage,
    this.isFront = true,
  });

  @override
  State<ImageUploadCard> createState() => _ImageUploadCardState();
}

class _ImageUploadCardState extends State<ImageUploadCard> {
  Uint8List? _webImage;
  File? _localImage;
  static const int maxFileSizeBytes = 5 * 1024 * 1024;

  @override
  void initState() {
    super.initState();
    _webImage = widget.initialWebImage;
    _localImage = widget.initialLocalImage;
  }

  Future<void> _pickImage() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['jpg', 'jpeg', 'png'],
      withData: kIsWeb,
    );

    if (result != null && result.files.isNotEmpty) {
      final file = result.files.first;
      int? fileSize;

      if (kIsWeb) {
        fileSize = file.bytes?.lengthInBytes;
      } else if (file.path != null) {
        final f = File(file.path!);
        fileSize = await f.length();
      }

      if (fileSize != null && fileSize > maxFileSizeBytes) {
        _showSnackBar("File is too large. Max size is 5MB.");
        return;
      }

      setState(() {
        if (kIsWeb) {
          _webImage = file.bytes;
          _localImage = null;
        } else if (file.path != null) {
          _localImage = File(file.path!);
          _webImage = null;
        }

        widget.onImageSelected(_webImage, _localImage);
      });
    }
  }

  void _removeImage() {
    setState(() {
      _webImage = null;
      _localImage = null;
      widget.onImageSelected(null, null);
    });
  }

  void _showSnackBar(String message) {
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
    }
  }

  @override
  Widget build(BuildContext context) {
    final hasImage = _webImage != null || _localImage != null;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.label,
          style: const TextStyle(
            fontWeight: FontWeight.normal,
            color: Color(0xFF000000),
            fontSize: 16,
          ),
        ),
        const SizedBox(height: 8),
        GestureDetector(
          onTap: _pickImage,
          child: Stack(
            children: [
              DashedBorderContainer(
                backgroundColor: hasImage ? Colors.white : const Color(0xFFF5F5F5),
                child: Center(
                  child: hasImage
                      ? (kIsWeb
                          ? Image.memory(
                              _webImage!,
                              width: 300,
                              height: 180,
                              fit: BoxFit.cover,
                            )
                          : Image.file(
                              _localImage!,
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
              if (hasImage)
                Positioned(
                  right: 4,
                  top: 4,
                  child: GestureDetector(
                    onTap: _removeImage,
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
        ),
      ],
    );
  }
}
