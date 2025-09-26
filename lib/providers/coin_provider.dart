import 'package:eto_pay/models/coin_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final coinsProvider = FutureProvider<List<Coin>>((ref) async {
  await Future.delayed(const Duration(milliseconds: 300)); // "api call"
  final rawData = [
    {
      'name': 'Shimmer',
      'symbol': 'SMR',
      'icon': 'assets/icons/icon_shimmer.svg',
    },
    {
      'name': 'Ethereum',
      'symbol': 'ETH',
      'icon': 'assets/icons/icon_eth.svg',
      'paint_in_gray': 'true'
    },
    {
      'name': 'Duno',
      'symbol': 'DUNO',
      'icon': 'assets/icons/icon_duno.svg',
    },
  ];

  return rawData.map((json) => Coin.fromJson(json)).toList();
});
