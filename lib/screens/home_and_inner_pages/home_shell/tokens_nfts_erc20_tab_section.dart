import 'package:eto_pay/models/network_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class TokensNfcsErc20TabSection extends StatefulWidget {
  final List<NetworkAsset> assetsTokens;
  final List<NetworkAsset> assetsNfts;
  final List<NetworkAsset> assetsErc20;
  const TokensNfcsErc20TabSection(
      {super.key,
      required this.assetsTokens,
      required this.assetsNfts,
      required this.assetsErc20});

  @override
  State<TokensNfcsErc20TabSection> createState() =>
      _TokensNfcsErc20TabSectionState();
}

class _TokensNfcsErc20TabSectionState extends State<TokensNfcsErc20TabSection>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 24, left: 20, right: 20, bottom: 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TabBar(
            controller: _tabController,
            labelColor: Colors.black,
            unselectedLabelColor: Colors.grey,
            labelStyle: const TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 14,
            ),
            indicatorColor: const Color(0xFF005CA9),
            tabs: const [
              Tab(text: 'Tokens'),
              Tab(text: 'NFTs'),
              Tab(text: 'ERC20'),
            ],
          ),
          const SizedBox(height: 12),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                _buildTokenListWithBackground(widget.assetsTokens),
                _buildTokenListWithBackground(widget.assetsNfts),
                _buildTokenListWithBackground(widget.assetsErc20)
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTokenListWithBackground(List<NetworkAsset> tokens) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFF0F0F0),
        borderRadius: BorderRadius.circular(8),
      ),
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
      child: _buildTokenListInner(tokens),
    );
  }

  Widget _buildTokenListInner(List<NetworkAsset> tokens) {
    if (tokens.isEmpty) {
      return const Center(
        child: Text('Tokens (empty)'),
      );
    }

    return Column(
      children: List.generate(tokens.length * 2 - 1, (index) {
        if (index.isOdd) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 6),
            child: Container(height: 1, color: Colors.grey[300]),
          );
        }
        final tokenIndex = index ~/ 2;
        final token = tokens[tokenIndex];
        final isPositive = token.change >= 0;
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
          child: Row(
            children: [
              SvgPicture.asset(
                token.icon,
                width: 20,
                height: 20,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      token.name,
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      token.price,
                      style: const TextStyle(
                        fontSize: 12,
                        color: Color(0xFF747474),
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    token.amount,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Row(
                    children: [
                      Icon(
                        isPositive ? Icons.arrow_upward : Icons.arrow_downward,
                        size: 12,
                        color: isPositive ? Colors.green : Colors.red,
                      ),
                      const SizedBox(width: 2),
                      Text(
                        '${token.change.abs().toStringAsFixed(2)}%',
                        style: TextStyle(
                          fontSize: 12,
                          color: isPositive ? Colors.green : Colors.red,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        );
      }),
    );
  }
}
