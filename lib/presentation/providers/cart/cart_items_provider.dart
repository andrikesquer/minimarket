import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:pos2/domain/entities/cart_item_entity.dart';
import 'package:pos2/domain/entities/shop_order_entity.dart';
import 'package:pos2/main.dart';

import 'package:pos2/domain/entities/product_entity.dart';

class CartItemsNotifier extends StateNotifier<List<CartItem>> {
  CartItemsNotifier() : super(objectbox.getCartItems());

  void refresh() {
    state = objectbox.getCartItems();
  }

  void add(CartItem item) {
    objectbox.addCartItem(item);
    refresh();
  }

  void remove(int productId) {
    objectbox.removeCartItem(productId);
    refresh();
  }

  void incrementQty(int productId) {
    final item = objectbox.existenceCheck(productId);

    if (item != null) {
      item.productQty++;
      objectbox.cartBox.put(item);
      refresh();
    }
  }

  void decrementQty(int productId) {
    final item = objectbox.existenceCheck(productId);

    if (item != null) {
      if (item.productQty > 1) {
        item.productQty--;
        objectbox.cartBox.put(item);
      } else {
        remove(productId);
      }
      refresh();
    }
  }

  void removeAll() {
    objectbox.removeAll();
    refresh();
  }

  void confirmOrder(List<CartItem> items) {
    if (items.isEmpty) return;

    final String date = DateFormat(
      'yyyy-MM-dd HH:mm:ss',
    ).format(DateTime.now());

    double total = 0;
    for (CartItem item in items) {
      total += item.subtotal;
      Product? product = objectbox.getProduct(item.productId);
      product?.stock = product.stock - item.productQty;
      objectbox.updateProduct(product!);
    }

    final ShopOrder order = ShopOrder(date: date, total: total);
    order.items.addAll(items);

    objectbox.saveOrder(order);
    removeAll();
  }
}

final cartItemsProvider =
    StateNotifierProvider<CartItemsNotifier, List<CartItem>>((ref) {
      return CartItemsNotifier();
    });
