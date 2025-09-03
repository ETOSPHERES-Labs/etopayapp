import 'package:eto_pay/models/payment_method_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final paymentMethodsProvider =
    FutureProvider<List<PaymentMethod>>((ref) async {
  await Future.delayed(const Duration(milliseconds: 300)); // "api call"
  final rawData = [
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

  return rawData.map((json) => PaymentMethod.fromJson(json)).toList();
});
