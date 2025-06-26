import 'package:flutter/material.dart';

class RecoveryPhraseViewModel with ChangeNotifier {
  bool _isRevealed = false;
  final List<String> _recoveryPhrase = [
    'apple',
    'banana',
    'cherry',
    'date',
    'elderberry',
    'fig',
    'grape',
    'honeydew',
    'kiwi',
    'lemon',
    'mango',
    'nectarine',
    'orange',
    'papaya',
    'quince',
    'raspberry',
    'strawberry',
    'tangerine',
    'ugli',
    'vanilla',
    'watermelon',
    'xigua',
    'yuzu',
    'zucchini'
  ];

  bool get isRevealed => _isRevealed;
  List<String> get recoveryPhrase => _recoveryPhrase;

  void reveal() {
    _isRevealed = true;
    notifyListeners();
  }
}
