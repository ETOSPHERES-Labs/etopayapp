import 'package:flutter_riverpod/flutter_riverpod.dart';

final paymentMethodsProvider =
    FutureProvider<List<Map<String, String>>>((ref) async {
  await Future.delayed(const Duration(milliseconds: 300)); // "api call"
  return [
    {
      'label': 'Sepa',
      'icon': 'assets/icons/icon_sepa.svg',
    },
    {
      'label': 'CC',
      'icon': 'assets/icons/icon_cc.svg',
    },
    {
      'label': 'Paypal',
      'icon': 'assets/icons/icon_paypal.svg',
    },
  ];
});
