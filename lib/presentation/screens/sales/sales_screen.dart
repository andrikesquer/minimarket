import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pos2/data/models/route_card_model.dart';
import 'package:pos2/presentation/screens/sales/widgets/sales/sales_app_bar.dart';
import 'package:pos2/presentation/widgets/routes_menu.dart';

class SalesScreen extends ConsumerWidget {
  const SalesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final List<RouteCardModel> routeModels = [
      RouteCardModel(
        route: 'sales/sell',
        routeName: 'Vender',
        backgroundColor: Colors.transparent,
      ),
      RouteCardModel(
        route: 'sales/history',
        routeName: 'Historial',
        backgroundColor: Colors.transparent,
      ),
    ];

    return SafeArea(
      child: Scaffold(
        appBar: SalesAppBar(),
        body: ListView(
          children: <Widget>[Center(child: RoutesMenu(routes: routeModels))],
        ),
      ),
    );
  }
}
