import 'package:flutter/material.dart';

class MainHomeHeaderViewModel extends ChangeNotifier {
  String _profileImage = 'assets/images/onboarding_bg_1.svg'; // Placeholder
  bool _profileVerified = true;
  String _selectedNetwork = 'Base';
  final List<String> _networks = ['Base', 'Ethereum', 'IOTA'];
  bool _hasUnviewedNotifications = true;
  int _notificationCount = 3;

  String get profileImage => _profileImage;
  bool get profileVerified => _profileVerified;
  String get selectedNetwork => _selectedNetwork;
  List<String> get networks => List.unmodifiable(_networks);
  bool get hasUnviewedNotifications => _hasUnviewedNotifications;
  int get notificationCount => _notificationCount;

  set selectedNetwork(String value) {
    _selectedNetwork = value;
    notifyListeners();
  }

  void markNotificationsViewed() {
    _hasUnviewedNotifications = false;
    _notificationCount = 0;
    notifyListeners();
  }

  // Add setters for profile image/verified if needed later
} 