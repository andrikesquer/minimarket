import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pos2/domain/entities/cart_item_entity.dart';
import 'package:pos2/main.dart';

class CartItemsNotifier extends StateNotifier<List<CartItem>> {
  CartItemsNotifier() : super(objectbox.getCartItems());

  void refresh() {
    state = objectbox.getCartItems();
  }

  void remove(int itemId) {
    objectbox.removeCartItem(itemId);
    refresh();
  }
}

final cartItemsProvider =
    StateNotifierProvider<CartItemsNotifier, List<CartItem>>((ref) {
      return CartItemsNotifier();
    });
