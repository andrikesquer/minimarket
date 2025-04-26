import 'package:flutter/material.dart';
import 'package:pos2/data/models/routes/route_card_model.dart';
import 'package:pos2/presentation/widgets/route_card.dart';

class RoutesMenu extends StatelessWidget {
  final List<RouteCardModel> routes;
  const RoutesMenu({super.key, required this.routes});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(15),
      child: Column(
        children:
            routes
                .map(
                  (RouteCardModel routeModel) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    child: RouteCard(model: routeModel),
                  ),
                )
                .toList(),
      ),
    );
  }
}
