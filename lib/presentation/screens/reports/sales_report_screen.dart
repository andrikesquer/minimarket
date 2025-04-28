import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SalesReportScreen extends StatelessWidget {
  const SalesReportScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              context.go('/reports');
            },
          ),
          title: Text('Reporte de ventas'),
          actions: [
            IconButton(
              icon: Icon(Icons.home),
              onPressed: () {
                context.go('/:email');
              },
            ),
          ],
        ),
      ),
    );
  }
}
