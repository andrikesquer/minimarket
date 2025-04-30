import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pos2/presentation/providers/sales_report_provider.dart';

class DatePicker extends ConsumerWidget {
  final int firstYear;
  final bool isStartDate;

  const DatePicker({
    super.key,
    required this.firstYear,
    required this.isStartDate,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedDate =
        isStartDate ? ref.watch(startDateProvider) : ref.watch(endDateProvider);

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Text(
          selectedDate != null
              ? '${selectedDate.day}/${selectedDate.month}/${selectedDate.year}'
              : 'Sin selección',
        ),
        OutlinedButton(
          onPressed: () async {
            final DateTime? pickedDate = await showDatePicker(
              context: context,
              firstDate: DateTime(firstYear),
              lastDate: DateTime.now(),
            );
            if (pickedDate != null) {
              if (isStartDate) {
                ref.read(startDateProvider.notifier).state = pickedDate;
              } else {
                ref.read(endDateProvider.notifier).state = pickedDate;
              }
            }
          },
          child: const Text('Seleccionar'),
        ),
      ],
    );
  }
}
