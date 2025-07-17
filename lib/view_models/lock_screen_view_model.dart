import 'package:flutter/material.dart';

class LockScreenViewModel extends ChangeNotifier {
  String _username = 'User001';
  String _profileImage = 'assets/images/onboarding_bg_1.svg'; // Placeholder image

  String get username => _username;
  String get profileImage => _profileImage;

  set username(String value) {
    _username = value;
    notifyListeners();
  }

  set profileImage(String value) {
    _profileImage = value;
    notifyListeners();
  }
} 