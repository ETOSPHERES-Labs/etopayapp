import 'package:eto_pay/view_models/recovery_phrase_view_model.dart';
import 'package:eto_pay/views/recovery_phrase_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RecoveryPhraseScreen extends StatelessWidget {
  const RecoveryPhraseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ChangeNotifierProvider(
          create: (context) => RecoveryPhraseViewModel(),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextButton(
                  style: TextButton.styleFrom(foregroundColor: Colors.black),
                  onPressed: () {
                    Navigator.of(context).popUntil((route) => route.isFirst);
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
                const SizedBox(height: 16),
                const Expanded(
                  child: RecoveryPhraseView(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
