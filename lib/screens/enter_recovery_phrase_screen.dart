import 'package:eto_pay/core/bip39_word_list.dart';
import 'package:eto_pay/core/text_styles.dart';
import 'package:eto_pay/widgets/mnemonic_input.dart';
import 'package:flutter/material.dart';
import 'package:eto_pay/core/colors.dart';

class EnterRecoveryPhraseScreen extends StatefulWidget {
  const EnterRecoveryPhraseScreen({super.key, required this.network});
  final String network;

  @override
  State<EnterRecoveryPhraseScreen> createState() =>
      _EnterRecoveryPhraseScreen();
}

class _EnterRecoveryPhraseScreen extends State<EnterRecoveryPhraseScreen> {
  final ValueNotifier<bool> _tapNotifier = ValueNotifier(false);

  // bool _isContinueButtonEnabled = false;
  // String _mnemonic = "";

  @override
  void dispose() {
    _tapNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: () {
            _tapNotifier.value = true;
          },
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
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
                    children: const [
                      Icon(Icons.arrow_back),
                      SizedBox(width: 8),
                      Text('Back'),
                    ],
                  ),
                ),
                const SizedBox(height: 18),
                Text(
                  'Enter your recovery phrase',
                  style: AppTextStyles.boldCentered,
                ),
                const SizedBox(height: 8),
                const Text(
                  'Please enter your recovery phrase. It is 24 words long, all lowercase, with spaces.',
                  style: TextStyle(color: AppColors.subtext),
                ),
                const SizedBox(height: 24),
                const Text(
                  'Enter your secret recovery phrase',
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),
                MnemonicInput(tapNotifier: _tapNotifier, wordList: WORDLIST),
                const SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
