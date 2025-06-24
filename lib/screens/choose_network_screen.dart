import 'package:eto_pay/widgets/onboarding.dart';
import 'package:flutter/material.dart';

class ChooseNetworkScreen extends StatelessWidget {
  const ChooseNetworkScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.arrow_back),
                Padding(padding: EdgeInsets.only(left: 8)),
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
      ),
    );
  }
}
