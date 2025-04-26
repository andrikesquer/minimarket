import 'package:flutter/material.dart';
import 'package:pos2/data/models/route_card_model.dart';
import 'package:pos2/presentation/widgets/routes_menu.dart';

class Home extends StatelessWidget {
  final String? email;
  const Home({super.key, this.email});

  @override
  Widget build(BuildContext context) {
    final List<RouteCardModel> routeModels = [
      RouteCardModel(
        route: 'products',
        routeName: 'Productos',
        backgroundColor: Colors.transparent,
      ),
      RouteCardModel(
        route: 'sales',
        routeName: 'Ventas',
        backgroundColor: Colors.transparent,
      ),
      RouteCardModel(
        route: 'settings',
        routeName: 'Ajustes',
        backgroundColor: Colors.transparent,
      ),
      RouteCardModel(
        route: 'reports',
        routeName: 'Reportes',
        backgroundColor: Colors.transparent,
      ),
    ];

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'MiniMarket',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
          ),
        ),
        body: ListView(
          children: <Widget>[Center(child: RoutesMenu(routes: routeModels))],
        ),
      ),
    );
  }
}
