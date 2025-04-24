import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pos2/domain/entities/cart_item_entity.dart';
import 'cart_item_card.dart';

class CartItemsList extends ConsumerWidget {
  final List<CartItem> items;
  const CartItemsList({super.key, required this.items});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListView.builder(
      scrollDirection: Axis.vertical,
      padding: EdgeInsets.all(15),
      itemCount: items.length,
      itemBuilder: (BuildContext context, int index) {
        return CartItemCard(item: items[index]);
      },
    );
  }
}
