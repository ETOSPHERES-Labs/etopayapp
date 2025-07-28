import 'dart:io';
import 'package:eto_pay/models/kyc_form_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class DocumentPhotoListPreview extends StatelessWidget {
  final String title;
  final List<Photo?> photos;

  const DocumentPhotoListPreview({
    super.key,
    required this.title,
    required this.photos,
  });

  @override
  Widget build(BuildContext context) {
    Widget imageWidget(dynamic image) {
      if (image == null) {
        return Container(
          width: 150,
          height: 100,
          color: Colors.grey[200],
          child: const Icon(Icons.image_not_supported, color: Colors.grey),
        );
      }

      return kIsWeb
          ? Image.memory(image as Uint8List,
              width: 150, height: 100, fit: BoxFit.cover)
          : Image.file(image as File,
              width: 150, height: 100, fit: BoxFit.cover);
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (title.trim().isNotEmpty) ...[
          Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
        ],
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: photos.map((photo) {
              final image = kIsWeb ? photo?.web : photo?.phone;
              return Padding(
                padding: const EdgeInsets.only(right: 16.0),
                child: imageWidget(image),
              );
            }).toList(),
          ),
        ),
        const SizedBox(height: 24),
      ],
    );
  }
}
