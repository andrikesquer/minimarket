import 'package:flutter/material.dart';
import 'package:pos2/presentation/screens/home/widgets/route_card.dart';

class ToggleScreen extends StatelessWidget {
  final List<RouteCard> routeCards;
  ToggleScreen({super.key, required this.routeCards});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(15),
      child:
      // SingleChildScrollView(
      //   child: ListView.builder(
      //     itemBuilder: (BuildContext context, int index) {
      //       RouteCard route = routeCards[index];
      //       return RouteCard(
      //         route: route.route,
      //         routeName: route.routeName,
      //         backgroundColor: route.backgroundColor,
      //       );
      //     },
      //   ),
      // ),
      Column(
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
            route: 'settings',
            routeName: 'Ajustes',
            backgroundColor: Colors.transparent,
          ),
          RouteCard(
            route: 'reports',
            routeName: 'Reportes',
            backgroundColor: Colors.transparent,
          ),
        ],
      ),
    );
  }
}
