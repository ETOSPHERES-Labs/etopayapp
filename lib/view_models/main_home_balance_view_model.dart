import 'package:flutter/material.dart';

class MainHomeBalanceViewModel extends ChangeNotifier {
  double _balance = 1234.56;
  bool _balanceVisible = true;
  double _euroValue = 789.01;

  double get balance => _balanceVisible ? _balance : 0.0;
  bool get balanceVisible => _balanceVisible;
  double get euroValue => _balanceVisible ? _euroValue : 0.0;

  void toggleVisibility() {
    _balanceVisible = !_balanceVisible;
    notifyListeners();
  }

  // Add setters for balance/euroValue if needed later
} 