import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pos2/domain/entities/cart_item_entity.dart';

class CartItemCard extends ConsumerWidget {
  final CartItem item;
  const CartItemCard({super.key, required this.item});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final ButtonStyle buttonStyle = ElevatedButton.styleFrom(
      elevation: 0,
      foregroundColor: Colors.black,
    );

    return Card.outlined(
      elevation: 0,
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          spacing: 5,
          children: [
            Icon(Icons.fastfood),
            Text(
              item.productName,
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
            Text('\$${item.subtotal}'),
            Column(
              children: [
                Text('Cantidad'),
                Row(
                  spacing: 5,
                  children: [
                    ElevatedButton(
                      style: buttonStyle,
                      onPressed: () {
                        debugPrint('decrement');
                        debugPrint('Item.productId: ${item.productId}');
                        debugPrint('item.productQuantity: ${item.productQuantity}');
                        // debugPrint('$counter');
                      },
                      child:
                          item.productQuantity == 1
                              ? Icon(Icons.delete_outline)
                              : Icon(Icons.remove),
                    ),
                    Text('${item.productQuantity}'),
                    ElevatedButton(
                      style: buttonStyle,
                      onPressed: () {
                        debugPrint('increment');
                        debugPrint('Item.productId: ${item.productId}');
                        debugPrint('item.productQuantity: ${item.productQuantity}');
                      },
                      child: Icon(Icons.add),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
