import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pos2/presentation/providers/products_provider.dart';
import 'package:pos2/presentation/screens/sales/widgets/sales.dart';

import '../home/widgets/route_card.dart';

class SalesScreen extends ConsumerWidget {
  const SalesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SafeArea(
      child: Scaffold(
        appBar: SalesAppBar(),
        body: ListView(children: <Widget>[Center(child: ToggleScreenSales())]),
      ),
    );
  }
}

class ToggleScreenSales extends StatelessWidget {
  const ToggleScreenSales({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(15),
      child: Column(
        spacing: 10,
        children: [
          RouteCard(
            route: 'sales/sell',
            routeName: 'Vender',
            backgroundColor: Colors.transparent,
          ),
          RouteCard(
            route: 'sales/history',
            routeName: 'Historial',
            backgroundColor: Colors.transparent,
          ),
        ],
      ),
    );
  }
}
