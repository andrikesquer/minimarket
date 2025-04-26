import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SalesHistoryAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  const SalesHistoryAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: IconButton(
        onPressed: () => context.go('/:email'),
        icon: Icon(Icons.arrow_back),
      ),
      title: const Text(
        'Historial de ventas',
        style: TextStyle(fontSize: 24, decoration: TextDecoration.none),
      ),
      actions: [
        IconButton(
          icon: Icon(Icons.shopping_cart_rounded),
          onPressed: () {
            context.go('/cart');
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
