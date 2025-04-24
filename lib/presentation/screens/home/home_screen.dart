import 'package:flutter/material.dart';
import 'package:pos2/presentation/screens/home/widgets/route_card.dart';

class Home extends StatelessWidget {
  final String? email;
  const Home({super.key, this.email});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: Text('MiniMarket')),
        body: ListView(children: <Widget>[Center(child: ToggleScreen())]),
      ),
    );
  }
}

class ToggleScreen extends StatelessWidget {
  const ToggleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(15),
      child: Column(
        spacing: 10,
        children: [
          RouteCard(
            route: 'products',
            routeName: 'Productos',
            backgroundColor: Colors.transparent,
          ),
          RouteCard(
            route: 'sales',
            routeName: 'Ventas',
            backgroundColor: Colors.transparent,
          ),
          RouteCard(
            route: 'configuration',
            routeName: 'Configuración',
            backgroundColor: Colors.transparent,
          ),
        ],
      ),
    );
  }
}
