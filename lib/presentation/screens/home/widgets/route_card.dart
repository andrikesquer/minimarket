import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class RouteCard extends StatelessWidget {
  final String route;
  final String routeName;

  final Color backgroundColor;

  const RouteCard({
    super.key,
    required this.route,
    required this.routeName,
    required this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return Card.outlined(
      color: backgroundColor,
      clipBehavior: Clip.hardEdge,
      child: InkWell(
        splashColor: Colors.blue.withAlpha(30),
        onTap: () {
          context.go('/$route');
        },
        child: SizedBox(
          width: double.maxFinite,
          height: 100,
          child: Center(
            child: Text('$routeName', style: TextStyle(fontSize: 20)),
          ),
        ),
      ),
    );
  }
}
