import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pos2/domain/entities/shop_order_entity.dart';
import 'package:pos2/presentation/screens/sales/widgets/sales_history/order_cart.dart';

class OrdersList extends ConsumerWidget {
  final List<ShopOrder> orders;
  const OrdersList({super.key, required this.orders});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListView.builder(
      scrollDirection: Axis.vertical,
      padding: EdgeInsets.all(15),
      itemCount: orders.length,
      itemBuilder: (BuildContext context, int index) {
        final order = orders[index];
        return OrderCart(order: order);
      },
    );
  }
}
