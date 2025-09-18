import 'package:eto_pay/main.dart';
import 'package:eto_pay/models/network_model.dart';
import 'package:eto_pay/widgets/blue_double_button.dart';
import 'package:flutter/material.dart';

class TransactionFilterModal extends StatefulWidget {
  final TransactionStatus? selectedStatus;
  final String? selectedDateRange;
  final void Function(String? status, String? dateRange) onApply;

  const TransactionFilterModal({
    super.key,
    this.selectedStatus,
    this.selectedDateRange,
    required this.onApply,
  });

  @override
  State<TransactionFilterModal> createState() => _TransactionFilterModalState();
}

class _TransactionFilterModalState extends State<TransactionFilterModal> {
  late TransactionStatus? selectedStatus;
  late String? selectedDateRange;

  final List<String> dateRanges = [
    'Last Month',
    'Last 3 Months',
    'Last 6 Months',
    'Last 1 Year',
    'Choose date'
  ];

  @override
  void initState() {
    super.initState();
    selectedStatus = widget.selectedStatus;
    selectedDateRange = widget.selectedDateRange;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: MediaQuery.of(context).viewInsets,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Transaction Filters',
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // STATUS
              Align(
                alignment: Alignment.centerLeft,
                child: Text('Status',
                    style: Theme.of(context).textTheme.bodyMedium),
              ),
              const SizedBox(height: 8),
              Column(
                children: TransactionStatus.values.map((status) {
                  IconData icon;
                  Color iconColor;

                  switch (status) {
                    case TransactionStatus.completed:
                      icon = Icons.check_circle;
                      iconColor = Colors.green;
                      break;
                    case TransactionStatus.failed:
                      icon = Icons.cancel;
                      iconColor = Colors.red;
                      break;
                    default: // processing
                      icon = Icons.access_time;
                      iconColor = Colors.orange;
                  }

                  return Container(
                    margin: const EdgeInsets.symmetric(vertical: 4),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF5F5F5),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: ListTile(
                      leading: Icon(icon, color: iconColor),
                      title: Text(status.name,
                          style: Theme.of(context).textTheme.bodyMedium),
                      trailing: Radio<TransactionStatus>(
                        value: status,
                        groupValue: selectedStatus,
                        onChanged: (value) =>
                            setState(() => selectedStatus = value),
                      ),
                      onTap: () => setState(() => selectedStatus = status),
                    ),
                  );
                }).toList(),
              ),

              const Divider(height: 32),

              // DATE RANGE
              Align(
                alignment: Alignment.centerLeft,
                child: Text('Date Range',
                    style: Theme.of(context).textTheme.bodyMedium),
              ),
              const SizedBox(height: 12),
              Align(
                alignment: Alignment.centerLeft,
                child: Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  children: dateRanges.map((range) {
                    final isSelected = selectedDateRange == range;

                    return GestureDetector(
                      onTap: () => setState(() => selectedDateRange = range),
                      child: Container(
                        width: 140,
                        height: 45,
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 20),
                        decoration: BoxDecoration(
                          color: const Color(0xFFF5F5F5),
                          borderRadius: BorderRadius.circular(6),
                          border: Border.all(
                            color:
                                isSelected ? Colors.black : Colors.transparent,
                            width: 1.5,
                          ),
                        ),
                        child: Center(
                          child: Text(
                            range,
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),

              const SizedBox(height: 32),

              Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 0),
                      child: BlueDoubleButton(
                        leftButton: BlueButtonData(
                          text: 'Clear all',
                          onPressed: () {
                            setState(() {
                              selectedStatus = null;
                              selectedDateRange = null;
                            });
                            widget.onApply(null, null);
                          },
                          isActive: true,
                          style: BlueButtonStyle(
                              activeColor: Color.fromARGB(255, 206, 222, 239),
                              textStyle: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(
                                    color: Color(0xFF005CA9),
                                  )),
                        ),
                        rightButton: BlueButtonData(
                          text: 'Apply',
                          isActive: true,
                          onPressed: () {
                            widget.onApply(
                                selectedStatus?.name, selectedDateRange);
                          },
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
