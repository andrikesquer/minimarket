import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pos2/data/models/routes/route_card_model.dart';

class RouteCard extends StatelessWidget {
  final RouteCardModel model;

  const RouteCard({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    return Card.outlined(
      color: model.backgroundColor,
      clipBehavior: Clip.hardEdge,
      child: InkWell(
        splashColor: Colors.blue.withAlpha(30),
        onTap: () {
          context.go('/${model.route}');
        },
        child: SizedBox(
          width: double.maxFinite,
          height: 100,
          child: Center(
            child: Text(model.routeName, style: TextStyle(fontSize: 20)),
          ),
        ),
      ),
    );
  }
}
