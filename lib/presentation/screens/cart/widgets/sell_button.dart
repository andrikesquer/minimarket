import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../providers/cart/cart_items_provider.dart';

class SellButton extends ConsumerWidget {
  final int itemsLength;
  const SellButton({super.key, required this.itemsLength});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ButtonStyle buttonStyle = ElevatedButton.styleFrom(
      elevation: 0,
      backgroundColor: Colors.black,
    );

    return Padding(
      padding: EdgeInsets.all(15),
      child: ElevatedButton(
        style: buttonStyle,
        onPressed: () {
          if (itemsLength > 0) {
            debugPrint('Vender');
            // ref.read(cartItemsProvider.notifier).removeAll();
            ref.read(cartItemsProvider.notifier).confirmOrder();
          } else {
            context.go('/sales');
          }
        },
        child: Text(
          itemsLength > 0 ? 'Vender' : 'Ver productos',
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
