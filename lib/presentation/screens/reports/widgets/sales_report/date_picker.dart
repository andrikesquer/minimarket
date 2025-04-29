import 'package:flutter/material.dart';

class DatePicker extends StatefulWidget {
  final int firstYear;

  const DatePicker({
    super.key,
    required this.firstYear,
  });

  @override
  State<DatePicker> createState() => _DatePickerState();
}

class _DatePickerState extends State<DatePicker> {
  late DateTime _firstDate;

  DateTime? selectedDate;

  @override
  void initState() {
    _firstDate = DateTime(widget.firstYear);
    super.initState();
  }

  Future<void> _selectDate() async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      firstDate: _firstDate,
      lastDate: DateTime.now(),
    );

    setState(() {
      selectedDate = pickedDate;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      spacing: 20,
      children: <Widget>[
        Text(
          selectedDate != null
              ? '${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}'
              : 'Sin selección',
        ),
        OutlinedButton(
          onPressed: () {
            _selectDate();
          },
          child: const Text('Seleccionar'),
        ),
      ],
    );
  }
}
