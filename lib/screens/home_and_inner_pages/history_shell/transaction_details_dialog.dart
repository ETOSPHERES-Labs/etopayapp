import 'package:eto_pay/main.dart';
import 'package:eto_pay/widgets/blue_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class TransactionDetailsDialog extends StatelessWidget {
  final String type;
  final bool isConfirmed;
  final String amountBTC;
  final String amountFiat;
  final String from;
  final String to;
  final String date;

  const TransactionDetailsDialog({
    super.key,
    required this.type,
    required this.isConfirmed,
    required this.amountBTC,
    required this.amountFiat,
    required this.from,
    required this.to,
    required this.date,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      backgroundColor: Colors.white,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  type,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: GestureDetector(
                    onTap: () => Navigator.of(context).pop(),
                    child: const Icon(Icons.close),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 28),
            SvgPicture.asset(
              "assets/icons/icon_transaction_ok.svg",
              width: 84,
              height: 84,
            ),
            const SizedBox(height: 8),
            Text(
              isConfirmed ? 'Confirmed' : 'Pending',
              style: Theme.of(context).textTheme.displayMedium,
            ),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFFF5F5F5),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Amount',
                        textAlign: TextAlign.start,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            amountBTC,
                            style:
                                Theme.of(context).textTheme.bodyMedium?.black(),
                          ),
                          Text(
                            amountFiat,
                            style:
                                Theme.of(context).textTheme.bodyMedium?.gray(),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  const Divider(
                    height: 1,
                    thickness: 1,
                    color: Color.fromARGB(237, 230, 230, 230),
                  ),
                  const SizedBox(height: 16),
                  _buildRow(context, 'From', from),
                  _buildRow(context, 'To', to),
                  _buildRow(context, 'Date', date),
                ],
              ),
            ),
            const SizedBox(height: 28),
            BlueButton(
              text: 'Download details',
              leftIcon: const Icon(Icons.download, color: Colors.white),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            SizedBox(
              height: 20,
            )
          ],
        ),
      ),
    );
  }

  Widget _buildRow(BuildContext context, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Expanded(
            child: Text(
              label,
              style: Theme.of(context).textTheme.labelMedium?.gray(),
            ),
          ),
          Text(value, style: Theme.of(context).textTheme.bodyMedium),
        ],
      ),
    );
  }
}
