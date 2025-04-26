import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:pos2/data/data_sources/objectbox_database.dart';
import 'package:pos2/domain/entities/shop_order_entity.dart';
import 'package:pos2/domain/repositories/order_repository.dart';
import 'package:pos2/domain/entities/cart_item_entity.dart';

class OrdersNotifier extends StateNotifier<List<ShopOrder>> {
  final OrderRepository _repository;

  OrdersNotifier(this._repository) : super([]) {
    refresh();
  }

  void refresh() {
    state = _repository.getAllOrders();
  }

  void add(ShopOrder shopOrder) {
    _repository.addOrder(shopOrder);
    refresh();
  }

  void confirmOrder(List<CartItem> items) {
    if (items.isEmpty) return;

    final String date = DateFormat(
      'yyyy-MM-dd HH:mm:ss',
    ).format(DateTime.now());

    double total = 0;
    final productBox = ObjectBoxDatabase.instance.productBox;
    for (CartItem item in items) {
      total += item.subtotal;
      // Actualización del stock del producto
      final product = productBox.get(item.productId);
      if (product != null) {
        product.stock -= item.productQty;
        productBox.put(product);
      }
    }

    // Construcción de la orden
    final order = ShopOrder(date: date, total: total);
    order.items.addAll(items);

    // Guardado de la orden
    _repository.addOrder(order);

    // Limpieza del carrito
    final cartBox = ObjectBoxDatabase.instance.cartBox;
    cartBox.removeAll();
    refresh();
  }
}

final orderRepositoryProvider = Provider<OrderRepository>((ref) {
  return OrderRepository();
});

final ordersProvider = StateNotifierProvider<OrdersNotifier, List<ShopOrder>>((
  ref,
) {
  final repository = ref.watch(orderRepositoryProvider);
  return OrdersNotifier(repository);
});
