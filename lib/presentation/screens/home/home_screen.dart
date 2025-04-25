import 'package:flutter/material.dart';
import 'package:pos2/presentation/screens/home/widgets/route_card.dart';
import 'package:pos2/presentation/screens/home/widgets/toggle_screen.dart';

class Home extends StatelessWidget {
  final String? email;
  const Home({super.key, this.email});

  @override
  Widget build(BuildContext context) {
    RouteCard products = RouteCard(
      route: 'products',
      routeName: 'Productos',
      backgroundColor: Colors.transparent,
    );

    RouteCard sales = RouteCard(
      route: 'sales',
      routeName: 'Ventas',
      backgroundColor: Colors.transparent,
    );

    RouteCard settings = RouteCard(
      route: 'settings',
      routeName: 'Ajustes',
      backgroundColor: Colors.transparent,
    );

    List<RouteCard> routeCards = [products, sales, settings];

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: Text('MiniMarket')),
        body: ListView(
          children: <Widget>[
            Center(child: ToggleScreen(routeCards: routeCards)),
          ],
        ),
      ),
    );
  }
}
