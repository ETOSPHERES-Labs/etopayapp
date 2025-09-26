import 'package:eto_pay/main.dart';
import 'package:eto_pay/models/network_model.dart';
import 'package:eto_pay/providers/user_provider.dart';
import 'package:eto_pay/screens/home_and_inner_pages/history_shell/transaction_details_dialog.dart';
import 'package:eto_pay/screens/home_and_inner_pages/history_shell/transaction_filter_modal.dart';
import 'package:eto_pay/screens/home_and_inner_pages/widgets/top_bar.dart';
import 'package:eto_pay/screens/home_and_inner_pages/widgets/top_bar_blue_background.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

class HistoryShellScreen extends ConsumerStatefulWidget {
  const HistoryShellScreen({super.key});

  @override
  ConsumerState<HistoryShellScreen> createState() => _HistoryShellScreenState();
}

class _HistoryShellScreenState extends ConsumerState<HistoryShellScreen> {
  TransactionStatus? _selectedStatus;
  String? _selectedDateRange;
  DateTimeRange? _chosenRange;

  void _showFilterModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      isScrollControlled: true,
      builder: (context) => TransactionFilterModal(
        selectedStatus: _selectedStatus,
        selectedDateRange: _selectedDateRange,
        onApply: (status, dateRange) async {
          if (dateRange == 'Choose date') {
            final now = DateTime.now();
            final result = await showDateRangePicker(
              context: context,
              firstDate: DateTime(2000),
              lastDate: now,
              initialDateRange: _chosenRange ??
                  DateTimeRange(
                    start: now.subtract(const Duration(days: 7)),
                    end: now,
                  ),
            );

            if (result != null) {
              setState(() {
                _selectedStatus = status != null
                    ? TransactionStatus.values.byName(status)
                    : null;
                _selectedDateRange = dateRange;
                _chosenRange = result;
              });
            }
          } else {
            setState(() {
              _selectedStatus = status != null
                  ? TransactionStatus.values.byName(status)
                  : null;
              _selectedDateRange = dateRange;
              _chosenRange = null;
            });
          }

          Navigator.of(context).pop();
        },
      ),
    );
  }

  bool _isWithinRange(String dateStr, String? range, String currentDateStr) {
    if (range == null) return true;

    final txDate = DateFormat("yyyy/MM/dd HH:mm").parse(dateStr);
    final now = DateFormat("yyyy/MM/dd HH:mm").parse(currentDateStr);
    final diff = now.difference(txDate);

    switch (range) {
      case 'Last 1 Month':
        return diff.inDays <= 30;
      case 'Last 3 Months':
        return diff.inDays <= 90;
      case 'Last 6 Months':
        return diff.inDays <= 180;
      case 'Last 1 Year':
        return diff.inDays <= 365;
      case 'Choose date':
        if (_chosenRange == null) return true;
        final start = DateTime(_chosenRange!.start.year,
            _chosenRange!.start.month, _chosenRange!.start.day);
        final end = DateTime(_chosenRange!.end.year, _chosenRange!.end.month,
            _chosenRange!.end.day, 23, 59, 59);
        return txDate
                .isAfter(start.subtract(const Duration(milliseconds: 1))) &&
            txDate.isBefore(end.add(const Duration(milliseconds: 1)));
      default:
        return true;
    }
  }

  bool _matchesStatus(
      NetworkTransaction tx, TransactionStatus? selectedStatus) {
    if (selectedStatus == null) return true;

    return tx.status == selectedStatus;
  }

  List<NetworkTransaction> _applyFilters(
      List<NetworkTransaction> all, String currentDateStr) {
    return all.where((tx) {
      return _matchesStatus(tx, _selectedStatus) &&
          _isWithinRange(tx.date, _selectedDateRange, currentDateStr);
    }).toList();
  }

  Widget _buildTransactionList(
      List<NetworkTransaction> transactions, String currentDateStr) {
    final currentDate = DateFormat("yyyy/MM/dd HH:mm").parse(currentDateStr);
    final today =
        DateTime(currentDate.year, currentDate.month, currentDate.day);
    final yesterday = today.subtract(const Duration(days: 1));

    final List<NetworkTransaction> todayTxs = [];
    final List<NetworkTransaction> yesterdayTxs = [];
    final List<NetworkTransaction> earlierTxs = [];

    for (final tx in transactions) {
      final txDate = DateFormat("yyyy/MM/dd HH:mm").parse(tx.date);
      final txDay = DateTime(txDate.year, txDate.month, txDate.day);

      if (txDay == today) {
        todayTxs.add(tx);
      } else if (txDay == yesterday) {
        yesterdayTxs.add(tx);
      } else {
        earlierTxs.add(tx);
      }
    }

    List<TransactionSection> buildSections() {
      final List<TransactionSection> sections = [];

      void addSection(String title, List<NetworkTransaction> list) {
        if (list.isEmpty) return;

        sections.add(
          TransactionSection(
            title: title,
            transactions: list.map((tx) {
              final txDate = DateFormat("yyyy/MM/dd HH:mm").parse(tx.date);
              final time = DateFormat("HH:mm").format(txDate);
              final subtitle =
                  "${tx.direction == TransactionsDirection.incoming ? 'Receive' : 'Sent'} $time";
              final prefix =
                  tx.direction == TransactionsDirection.incoming ? '+' : '-';

              return TransactionData(
                icon: SvgPicture.asset(tx.icon, width: 20, height: 20),
                label: tx.symbol,
                subtitle: subtitle,
                amount: '$prefix${tx.amount}',
              );
            }).toList(),
          ),
        );
      }

      addSection("Today", todayTxs);
      addSection("Yesterday", yesterdayTxs);
      addSection("Earlier", earlierTxs);

      return sections;
    }

    return ListView(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      children: buildSections(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(requireUserProvider);
    final preferredNetwork = user.networks.networkFor(user.preferredNetwork);
    final currentDate = "2024/05/20 12:32";

    final filteredTransactions =
        _applyFilters(preferredNetwork?.transactions ?? [], currentDate);

    return SafeArea(
      child: SingleChildScrollView(
        child: CustomPaint(
          painter: TopBarBlueBackgroundPainter(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TopBar(),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: const Color(0xFFF5F5F5),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: TextField(
                        decoration: InputDecoration(
                          icon: Icon(Icons.search),
                          hintText: 'Search transactions',
                          border: InputBorder.none,
                        ),
                        style: Theme.of(context).textTheme.bodyMedium?.gray(),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          height: 35,
                          child: TextButton(
                            style: TextButton.styleFrom(
                              backgroundColor: const Color(0xFFF5F5F5),
                              padding: const EdgeInsets.symmetric(
                                  vertical: 8, horizontal: 10),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(6)),
                            ),
                            onPressed: () {},
                            child: Row(
                              children: [
                                Text('Download transactions',
                                    style:
                                        Theme.of(context).textTheme.bodyMedium),
                                SizedBox(width: 6),
                                Icon(Icons.download, size: 16),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 35,
                          child: TextButton(
                            style: TextButton.styleFrom(
                              backgroundColor: const Color(0xFFF5F5F5),
                              padding: const EdgeInsets.symmetric(
                                  vertical: 8, horizontal: 10),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(6)),
                            ),
                            onPressed: () => _showFilterModal(context),
                            child: Row(
                              children: [
                                Text('Filters',
                                    style:
                                        Theme.of(context).textTheme.bodyMedium),
                                SizedBox(width: 6),
                                Icon(Icons.filter_list, size: 16),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    _buildTransactionList(filteredTransactions, currentDate),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class TransactionSection extends StatelessWidget {
  final String title;
  final List<TransactionData> transactions;

  const TransactionSection({
    super.key,
    required this.title,
    required this.transactions,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 16),
        Text(title,
            style: Theme.of(context).textTheme.labelLarge?.black().bold()),
        const SizedBox(height: 8),
        Column(
            children:
                transactions.map((tx) => TransactionTile(data: tx)).toList()),
      ],
    );
  }
}

class TransactionData {
  final SvgPicture icon;
  final String label;
  final String subtitle;
  final String amount;

  const TransactionData({
    required this.icon,
    required this.label,
    required this.subtitle,
    required this.amount,
  });
}

class TransactionTile extends StatelessWidget {
  final TransactionData data;

  const TransactionTile({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    final bool isNegative = data.amount.trim().startsWith('-');

    return Container(
      height: 68,
      margin: const EdgeInsets.symmetric(vertical: 6),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6),
        boxShadow: const [
          BoxShadow(
            color: Color.fromARGB(102, 105, 105, 105),
            blurRadius: 4,
            offset: Offset(0, 0),
          ),
        ],
      ),
      child: Material(
        color: Colors.white,
        borderRadius: BorderRadius.circular(6),
        child: InkWell(
          borderRadius: BorderRadius.circular(6),
          onTap: () {
            showDialog(
              context: context,
              builder: (context) => TransactionDetailsDialog(
                type: 'Sent ${data.label}',
                isConfirmed: true,
                amountBTC: '0.623${data.label}',
                amountFiat: '€ 35.23',
                from: 'Dashgvkas',
                to: 'JHbklmsjn',
                date: 'Jul 31 at 12:32',
              ),
            );
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Row(
              children: [
                data.icon,
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(data.label,
                          style: Theme.of(context)
                              .textTheme
                              .labelSmall
                              ?.black()
                              .bold()),
                      Text(data.subtitle,
                          style:
                              Theme.of(context).textTheme.labelSmall?.gray()),
                    ],
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      data.amount,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: isNegative ? Colors.red : Colors.green,
                          ),
                    ),
                  ],
                ),
                const SizedBox(width: 8),
                const Icon(Icons.chevron_right),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
