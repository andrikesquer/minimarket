import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pos2/domain/entities/shop_order_entity.dart';

class OrderCart extends ConsumerWidget {
  final ShopOrder order;
  const OrderCart({super.key, required this.order});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Card.outlined(
      clipBehavior: Clip.hardEdge,
      elevation: 0,
      child: InkWell(
        splashColor: Colors.blue.withAlpha(30),
        onTap: () {
          debugPrint('Mostrar detalles');
        },
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            spacing: 5,
            children: [
              Icon(Icons.sell_outlined),
              Text(
                'ID: ${order.id}',
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
              Text('\$${order.total}'),
              Text('Fecha: ${order.date}'),
            ],
          ),
        ),
      ),
    );
  }
}
