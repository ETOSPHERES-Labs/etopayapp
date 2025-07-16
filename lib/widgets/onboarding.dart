import 'package:eto_pay/core/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:eto_pay/core/colors.dart';

class CardData {
  final String title;
  final String? subtitle;
  final IconData? icon;
  final VoidCallback onTap;

  CardData({
    required this.title,
    this.subtitle,
    this.icon,
    required this.onTap,
  });
}

class ImageCardListWidget extends StatelessWidget {
  final String svgAssetPath;
  final String textData;
  final String? subtitle;
  final List<CardData> cards;
  final bool showCheckbox;
  final bool isChecked;
  final ValueChanged<bool?>? onCheckboxChanged;
  final String checkboxLabel;
  final Widget? footer;
  final Widget? contentBeforeFooter;

  const ImageCardListWidget({
    super.key,
    required this.svgAssetPath,
    this.textData = "",
    this.subtitle,
    this.cards = const [],
    this.showCheckbox = false,
    this.isChecked = false,
    this.onCheckboxChanged,
    this.checkboxLabel = 'Accept terms',
    this.footer,
    this.contentBeforeFooter,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SvgPicture.asset(
            svgAssetPath,
            height: 374,
            fit: BoxFit.contain,
          ),
          const SizedBox(height: 24),
          Text(textData, style: AppTextStyles.boldCentered),
          if (subtitle != null) ...[
            const SizedBox(height: 8),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                subtitle!,
                style: const TextStyle(
                  color: AppColors.subtext,
                  fontSize: 14,
                ),
                textAlign: TextAlign.left,
              ),
            ),
          ],
          ...cards.map((cardData) => Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Card(
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  clipBehavior: Clip.antiAlias,
                  child: InkWell(
                    onTap: cardData.onTap,
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Row(
                        children: [
                          if (cardData.icon != null) ...[
                            Icon(cardData.icon, size: 24),
                            const SizedBox(width: 16),
                          ],
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  cardData.title,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                  ),
                                ),
                                if (cardData.subtitle != null) ...[
                                  const SizedBox(height: 4),
                                  Text(cardData.subtitle!),
                                ],
                              ],
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.all(4),
                            decoration: BoxDecoration(
                              color: const Color(0xFF005CA9),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: const Icon(
                              Icons.arrow_forward_ios,
                              color: Colors.white,
                              size: 16,
                            ),
                          ),
                        ],
                      ),
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
          if (contentBeforeFooter != null) ...[
            const SizedBox(height: 16),
            contentBeforeFooter!,
          ],
          if (footer != null) footer!,
        ],
      ),
    );
  }
}
