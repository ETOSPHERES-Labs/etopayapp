enum TransactionsDirection { incoming, outgoing }

class NetworkTransaction {
  final String icon;
  final String symbol;
  final String date;
  final TransactionsDirection direction;
  final String amount;

  const NetworkTransaction({
    required this.icon,
    required this.symbol,
    required this.date,
    required this.direction,
    required this.amount,
  });
}

class NetworkAsset {
  final String icon;
  final String name;
  final String price;
  final String amount;
  final double change;

  const NetworkAsset(
      this.icon, this.name, this.price, this.amount, this.change);
}

class NetworkModel {
  final String id;
  final String name;
  final String symbol;
  final String icon;
  final String address; // @user tmp
  final double amount; // @user tmp
  final List<NetworkAsset> assetsTokens; // tmp
  final List<NetworkAsset> assetsNfts; // tmp
  final List<NetworkAsset> assetsErc20; // tmp
  final List<NetworkTransaction> transactions; // tmp

  const NetworkModel(
      this.id,
      this.name,
      this.symbol,
      this.icon,
      this.address,
      this.amount,
      this.assetsTokens,
      this.assetsNfts,
      this.assetsErc20,
      this.transactions);
}

class NetworksModel {
  final Map<String, NetworkModel> networks;

  static const Map<String, NetworkModel> defaultNetworks = {
    "1": NetworkModel("1", 'Shimmer Network', 'SMR',
        'assets/icons/icon_shimmer.svg', '0x000000B0B', 1232500.99, [
      NetworkAsset("assets/icons/icon_eth.svg", 'Ethereum', '€ 1.234,7',
          '2.6348 ETH', 4.07),
      NetworkAsset("assets/icons/icon_binance.svg", 'Binance', '€ 1.034,7',
          '3.2348 BNB', -2.15),
      NetworkAsset("assets/icons/icon_razer.svg", 'Razer', '€ 2.234,7',
          '4.1368 RRR', 1.23),
    ], [], [], [
      NetworkTransaction(
        icon: "assets/icons/icon_eth.svg",
        symbol: 'ETH',
        direction: TransactionsDirection.incoming,
        date: '2024/05/20 12:32',
        amount: '€ 430.00',
      ),
      NetworkTransaction(
        icon: "assets/icons/icon_btc.svg",
        symbol: 'BTC',
        direction: TransactionsDirection.outgoing,
        date: '2024/05/20 13:32',
        amount: '€ 20.00',
      ),
      NetworkTransaction(
        icon: "assets/icons/icon_btc.svg",
        symbol: 'BTC',
        direction: TransactionsDirection.outgoing,
        date: '2024/05/19 14:32',
        amount: '€ 12.50',
      ),
      NetworkTransaction(
        icon: "assets/icons/icon_btc.svg",
        symbol: 'BTC',
        direction: TransactionsDirection.outgoing,
        date: '2024/05/19 15:32',
        amount: '€ 45.00',
      ),
      NetworkTransaction(
        icon: "assets/icons/icon_eth.svg",
        symbol: 'ETH',
        direction: TransactionsDirection.incoming,
        date: '2024/05/16 16:32',
        amount: '€ 430.00',
      ),
    ]),
    "2": NetworkModel("2", 'ETH Network', 'ETH', 'assets/icons/icon_eth.svg',
        'AbCdEfGh55', 551236.00, [], [], [], []),
    "3": NetworkModel("3", 'Binance Network', 'BNC',
        'assets/icons/icon_binance.svg', 'BNCx0134567', 555.45, [], [], [], []),
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
