import 'dart:math';
import 'package:flutter/material.dart';

class RecoveryPhraseVerificationViewModel with ChangeNotifier {
  final List<String> recoveryPhrase;
  final List<List<String>> options;
  final List<int?> userAnswers;
  int currentIndex = 0;

  RecoveryPhraseVerificationViewModel(this.recoveryPhrase)
      : options = List.generate(24, (i) => []),
        userAnswers = List.filled(24, null) {
    _generateOptions();
  }

  void _generateOptions() {
    final random = Random();
    for (int i = 0; i < 24; i++) {
      final correct = recoveryPhrase[i];
      final distractors = <String>{};
      while (distractors.length < 2) {
        final candidate = recoveryPhrase[random.nextInt(24)];
        if (candidate != correct) distractors.add(candidate);
      }
      final opts = [correct, ...distractors];
      opts.shuffle(random);
      options[i] = opts;
    }
  }

  void selectAnswer(int answerIdx) {
    userAnswers[currentIndex] = answerIdx;
    notifyListeners();
  }

  void next() {
    if (currentIndex < 23) {
      currentIndex++;
      notifyListeners();
    }
  }

  bool get isLast => currentIndex == 23;
  bool get canProceed => userAnswers[currentIndex] != null;

  bool get isVerified => List.generate(
          24, (i) => options[i][userAnswers[i] ?? -1] == recoveryPhrase[i])
      .every((v) => v);

  void reset() {
    currentIndex = 0;
    for (int i = 0; i < userAnswers.length; i++) {
      userAnswers[i] = null;
    }
    notifyListeners();
  }
}
