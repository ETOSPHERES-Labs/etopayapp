class Coin {
  final String name;
  final String symbol;
  final String icon;
  final bool paintInGray;

  Coin({
    required this.name,
    required this.symbol,
    required this.icon,
    this.paintInGray = false,
  });

  factory Coin.fromJson(Map<String, dynamic> json) {
    return Coin(
      name: json['name'] as String,
      symbol: json['symbol'] as String,
      icon: json['icon'] as String,
      paintInGray: json['paint_in_gray'] == 'true',
    );
  }

  Map<String, dynamic> toJson() => {
    'name': name,
    'symbol': symbol,
    'icon': icon,
    'paint_in_gray': paintInGray.toString(),
  };
}
