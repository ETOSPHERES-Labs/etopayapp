import 'package:eto_pay/models/network_model.dart';
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
    'Last 1 Month',
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
                  const Text(
                    'Transaction Filters',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // STATUS
              const Align(
                alignment: Alignment.centerLeft,
                child: Text('Status',
                    style: TextStyle(fontWeight: FontWeight.bold)),
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
                      title: Text(status.toString()),
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
              const Align(
                alignment: Alignment.centerLeft,
                child: Text('Date Range',
                    style: TextStyle(fontWeight: FontWeight.bold)),
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
                        width: 134,
                        height: 39,
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
                            style: const TextStyle(
                              fontSize: 16,
                              fontFamily: 'Roboto',
                              fontWeight: FontWeight.w400,
                              color: Colors.black,
                              height: 1.0,
                              letterSpacing: 0,
                            ),
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),

              const SizedBox(height: 32),

              // BUTTONS
              Row(
                children: [
                  // Clear all
                  Expanded(
                    flex: 1,
                    child: TextButton(
                      onPressed: () {
                        setState(() {
                          selectedStatus = null;
                          selectedDateRange = null;
                        });
                        widget.onApply(null, null);
                      },
                      style: TextButton.styleFrom(
                        backgroundColor: const Color(0x1A005CA9),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6)),
                        padding: const EdgeInsets.symmetric(
                            vertical: 20, horizontal: 20),
                      ),
                      child: const Text(
                        "Clear all",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),

                  // Apply
                  Expanded(
                    flex: 1,
                    child: ElevatedButton(
                      onPressed: () {
                        widget.onApply(selectedStatus?.name, selectedDateRange);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0x80005CA9),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6)),
                        padding: const EdgeInsets.symmetric(
                            vertical: 20, horizontal: 20),
                      ),
                      child: const Text(
                        "Apply",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
