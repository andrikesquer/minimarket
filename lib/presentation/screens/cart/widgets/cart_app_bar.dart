import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CartAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CartAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: IconButton(
        icon: Icon(Icons.arrow_back),
        onPressed: () {
          context.go('/sales');
        },
      ),
      title: Text(
        'Carrito de Ventas',
        style: TextStyle(fontSize: 24, decoration: TextDecoration.none),
      ),
      actions: [
        IconButton(
          icon: Icon(Icons.sell),
          onPressed: () {
            context.go('/sales');
          },
        ),
        IconButton(
          icon: Icon(Icons.home),
          onPressed: () {
            context.go('/:email');
          },
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
