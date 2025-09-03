class NetworkModel {
  final String id;
  final String name;
  final String symbol;
  final String icon;
  final String address; // @user tmp
  final double amount; // @user tmp

  const NetworkModel(this.id, this.name, this.symbol, this.icon, this.address, this.amount);
}

class NetworksModel {
  final Map<String, NetworkModel> networks;

  static const Map<String, NetworkModel> defaultNetworks = {
    "1": NetworkModel("1", 'Shimmer Network', 'SMR', 'assets/icons/icon_shimmer.svg', '0x000000B0B', 1232500.99),
    "2": NetworkModel("2", 'ETH Network', 'ETH', 'assets/icons/icon_eth.svg', 'AbCdEfGh55', 551236.00),
    "3": NetworkModel("3", 'Binance Network', 'BNC', 'assets/icons/icon_binance.svg', 'BNCx0134567', 555.45),
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

  NetworkModel? networkFor(String? networkId) {
    if (networkId == null) return null;

    final network = networks[networkId];
    if (network != null) {
      return network;
    }

    return null;
  }
}
