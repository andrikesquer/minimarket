import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ProductsAppBar extends StatelessWidget implements PreferredSizeWidget {
  const ProductsAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: IconButton(
        icon: Icon(Icons.arrow_back),
        onPressed: () {
          context.go('/:email');
        },
      ),
      title: Text(
        'Productos',
        style: TextStyle(fontSize: 24, decoration: TextDecoration.none),
      ),
      actions: [
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
