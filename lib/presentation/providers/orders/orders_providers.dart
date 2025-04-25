import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pos2/domain/entities/shop_order_entity.dart';
import 'package:pos2/main.dart';

class OrdersNotifier extends StateNotifier<List<ShopOrder>> {
  OrdersNotifier() : super(objectbox.getAllOrders());

  void refresh() {
    state = objectbox.getAllOrders();
  }

  void add(ShopOrder shopOrder) {
    objectbox.saveOrder(shopOrder);
  }
}

final ordersProvider = StateNotifierProvider<OrdersNotifier, List<ShopOrder>>((
  ref,
) {
  return OrdersNotifier();
});
