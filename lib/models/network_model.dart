class NetworkModel {
  final String id;
  final String name;
  final String icon;

  const NetworkModel(this.id, this.name, this.icon);
}

class NetworksModel {
  final Map<String, NetworkModel> networks;

  static const Map<String, NetworkModel> defaultNetworks = {
    "1": NetworkModel("1", 'Shimmer Network', 'assets/icons/icon_shimmer.svg'),
    "2": NetworkModel("2", 'ETH Network', 'assets/icons/icon_eth.svg'),
    "3": NetworkModel("3", 'Binance Network', 'assets/icons/icon_binance.svg'),
  };

  NetworksModel([Map<String, NetworkModel>? networks])
      : networks = networks ?? defaultNetworks;

  NetworksModel copyWith({
    Map<String, NetworkModel>? networks,
  }) {
    return NetworksModel(
      networks ?? this.networks,
    );
  }

  String iconFor(String? networkId) {
    const fallbackIcon = 'assets/icons/icon_network_without_icon.svg';

    if (networkId == null) return fallbackIcon;

    final network = networks[networkId];
    if (network != null) {
      return network.icon;
    }

    return fallbackIcon;
  }

  String? nameFor(String? networkId) {
    if (networkId == null) return null;

    final network = networks[networkId];
    if (network != null) {
      return network.name;
    }

    return null;
  }
}
