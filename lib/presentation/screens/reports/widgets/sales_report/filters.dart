import 'package:flutter/material.dart';
import 'package:pos2/presentation/screens/reports/widgets/sales_report/date_picker.dart';

class Filters extends StatelessWidget {
  final int startYear;

  const Filters({super.key, required this.startYear});

  @override
  Widget build(BuildContext context) {
    debugPrint('$startYear');
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            children: [
              Text(
                'Filtrar por fecha',
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  DatePicker(firstYear: startYear),
                  Icon(Icons.arrow_forward),
                  DatePicker(firstYear: startYear),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
