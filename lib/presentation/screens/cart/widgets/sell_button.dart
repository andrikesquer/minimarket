import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pos2/presentation/providers/orders_provider.dart';
import 'package:pos2/presentation/providers/products/products_provider.dart';
import 'package:pos2/presentation/providers/cart/cart_items_provider.dart';
import 'package:go_router/go_router.dart';
import 'package:pos2/domain/entities/cart_item_entity.dart';

class SellButton extends ConsumerWidget {
  final List<CartItem> items;
  const SellButton({super.key, required this.items});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ButtonStyle buttonStyle = ElevatedButton.styleFrom(elevation: 0);

    return Padding(
      padding: EdgeInsets.all(15),
      child: ElevatedButton(
        style: buttonStyle,
        onPressed: () {
          if (items.isEmpty) {
            context.go('/sales/sell');
          } else {
            ref.read(ordersProvider.notifier).confirmOrder(items);
            ref.read(productsProvider.notifier).refresh();
            ref.read(cartItemsProvider.notifier).refresh();
          }
        },
        child: Text(items.isEmpty ? 'Ver productos' : 'Vender'),
      ),
    );
  }
}
