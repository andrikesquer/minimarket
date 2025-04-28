import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pos2/data/models/route_card_model.dart';
import 'package:pos2/presentation/widgets/routes_menu.dart';

class ReportsScreen extends StatelessWidget {
  const ReportsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<RouteCardModel> routeModels = [
      RouteCardModel(
        route: 'reports/sales',
        routeName: 'Reporte de ventas',
        backgroundColor: Colors.transparent,
      ),
    ];

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              context.go('/:email');
            },
          ),
          title: Text('Reportes'),
          actions: [
            IconButton(
              icon: Icon(Icons.home),
              onPressed: () {
                context.go('/:email');
              },
            ),
          ],
        ),
        body: ListView(
          children: <Widget>[Center(child: RoutesMenu(routes: routeModels))],
        ),
      ),
    );
  }
}
