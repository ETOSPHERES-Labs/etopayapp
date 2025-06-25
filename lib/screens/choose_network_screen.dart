import 'package:eto_pay/widgets/onboarding.dart';
import 'package:flutter/material.dart';

class ChooseNetworkScreen extends StatelessWidget {
  const ChooseNetworkScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextButton(
                  style: TextButton.styleFrom(foregroundColor: Colors.black),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.arrow_back),
                      SizedBox(width: 8),
                      Text('Back'),
                    ],
                  ),
                ),
                Expanded(
                    child: ImageCardListWidget(
                  svgAssetPath: 'assets/images/choose_network_bg.svg',
                  textData: 'Choose Network',
                  showCheckbox: false,
                )),
              ],
            )));
  }
}
