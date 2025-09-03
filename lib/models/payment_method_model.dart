class PaymentMethod {
  final String label;
  final String icon;

  PaymentMethod({
    required this.label,
    required this.icon
  });

  factory PaymentMethod.fromJson(Map<String, dynamic> json) {
    return PaymentMethod(label: json['label'] as String, icon: json['icon'] as String);
  }

  Map<String, dynamic> toJson() => {
    'label': label,
    'icon': icon
  };
}
