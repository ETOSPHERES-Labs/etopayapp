import 'package:eto_pay/core/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CardData {
  final Widget content;
  final VoidCallback onTap;

  CardData({required this.content, required this.onTap});
}

class ImageCardListWidget extends StatelessWidget {
  final String svgAssetPath;
  final String textData;
  final List<CardData> cards;
  final bool showCheckbox;
  final bool isChecked;
  final ValueChanged<bool?>? onCheckboxChanged;
  final String checkboxLabel;

  const ImageCardListWidget({
    super.key,
    required this.svgAssetPath,
    this.textData = "",
    this.cards = const [],
    this.showCheckbox = false,
    this.isChecked = false,
    this.onCheckboxChanged,
    this.checkboxLabel = 'Accept terms',
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SvgPicture.asset(
            svgAssetPath,
            height: 374,
            fit: BoxFit.contain,
          ),
          const SizedBox(height: 24),
          Text(textData, style: AppTextStyles.boldCentered),
          ...cards.map((cardData) => Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: GestureDetector(
                  onTap: cardData.onTap,
                  child: Card(
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: cardData.content,
                    ),
                  ),
                ),
              )),
          if (showCheckbox) ...[
            const SizedBox(height: 30),
            Row(
              children: [
                Checkbox(
                  value: isChecked,
                  onChanged: onCheckboxChanged,
                ),
                Expanded(
                  child: Text(
                    checkboxLabel,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }
}
