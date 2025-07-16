import 'package:eto_pay/widgets/conditional_button.dart';
import 'package:eto_pay/widgets/onboarding.dart';
import 'package:flutter/material.dart';

class ChooseCustomNetworkScreen extends StatefulWidget {
  const ChooseCustomNetworkScreen({super.key});

  @override
  State<ChooseCustomNetworkScreen> createState() =>
      _ChooseCustomNetworkScreen();
}

class _ChooseCustomNetworkScreen extends State<ChooseCustomNetworkScreen> {
  final List<Map<String, String>> networks = [
    {
      'name': 'Ethereum',
      'coin': 'ETH',
      'node': 'https://mainnet.infura.io/v3/...',
      'username': 'eth_user',
      'something': 'eth_brrr'
    },
    {
      'name': 'Bitcoin',
      'coin': 'BTC',
      'node': 'https://btcnode.org',
      'username': 'btc_user',
      'something': 'btc_brrr'
    },
    {
      'name': 'Polygon',
      'coin': 'MATIC',
      'node': 'https://polygon-rpc.com',
      'username': '',
      'something': ''
    },
  ];

  Map<String, String>? selectedNetwork;

  final TextEditingController coinController = TextEditingController();
  final TextEditingController nodeController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController somethingController = TextEditingController();

  bool _isContinueButtonEnabled = false;
  static const double _continueButtonHeight = 64;

  void _setContinueButtonState(bool isValid) {
    setState(() {
      _isContinueButtonEnabled = isValid;
    });
  }

  final InputDecoration defaultDecoration = InputDecoration(
    contentPadding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 16.0),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(6.0),
      borderSide: BorderSide(color: Color(0xFFF5F5F5)),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(6.0),
      borderSide: BorderSide(color: Color(0xFFF5F5F5)),
    ),
    filled: true,
    fillColor: Color(0xFFF5F5F5),
  );

  InputDecoration activeDecoration() {
    return defaultDecoration.copyWith(
      fillColor: Colors.white,
    );
  }

  TextStyle textStyle(bool enabled) {
    return const TextStyle(
      fontSize: 16,
      color: Color(0xFF747474),
    );
  }

  void _updateControllers(Map<String, String> network) {
    coinController.text = network['coin'] ?? '';
    nodeController.text = network['node'] ?? '';
    usernameController.text = network['username'] ?? '';
    somethingController.text = network['something'] ?? '';

    _setContinueButtonState(coinController.text.isNotEmpty);
  }

  Widget _buildTextField(
    String label,
    TextEditingController controller,
    bool isActive,
  ) {
    return SizedBox(
      height: 53,
      child: TextFormField(
        controller: controller,
        enabled: false,
        style: textStyle(isActive),
        decoration:
            (isActive ? activeDecoration() : defaultDecoration).copyWith(
          labelText: label,
        ),
      ),
    );
  }

  @override
  void dispose() {
    coinController.dispose();
    nodeController.dispose();
    usernameController.dispose();
    somethingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bool isNetworkSelected = selectedNetwork != null;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        top: true,
        bottom: true,
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextButton(
                      style:
                          TextButton.styleFrom(foregroundColor: Colors.black),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.arrow_back),
                          SizedBox(width: 8),
                          Text('Back'),
                        ],
                      ),
                    ),
                    ImageCardListWidget(
                      svgAssetPath: 'assets/images/choose_network_bg.svg',
                      subtitle: 'Connect to a custom network',
                      contentBeforeFooter: Column(
                        children: [
                          SizedBox(
                            height: 53,
                            child: DropdownButtonFormField<Map<String, String>>(
                              decoration: activeDecoration()
                                  .copyWith(labelText: 'Network'),
                              value: selectedNetwork,
                              style: textStyle(true),
                              items: networks.map((network) {
                                return DropdownMenuItem(
                                  value: network,
                                  child: Text(network['name']!),
                                );
                              }).toList(),
                              onChanged: (network) {
                                setState(() {
                                  selectedNetwork = network;
                                  if (network != null) {
                                    _updateControllers(network);
                                  }
                                });
                              },
                            ),
                          ),
                          const SizedBox(height: 12),
                          _buildTextField(
                              'Coin type', coinController, isNetworkSelected),
                          const SizedBox(height: 12),
                          _buildTextField('Node address', nodeController,
                              isNetworkSelected),
                          const SizedBox(height: 12),
                          _buildTextField('Username (optional)',
                              usernameController, isNetworkSelected),
                          const SizedBox(height: 12),
                          _buildTextField('something (optional)',
                              somethingController, isNetworkSelected),
                          const SizedBox(height: 16),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              height: _continueButtonHeight,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ConditionalButton(
                    isActive: _isContinueButtonEnabled,
                    onPressed: () {},
                    text: 'Continue',
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
