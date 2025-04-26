import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pos2/domain/entities/cart_item_entity.dart';
import 'package:pos2/domain/repositories/cart_repository.dart';

class CartItemsNotifier extends StateNotifier<List<CartItem>> {
  final CartRepository _repository;

  CartItemsNotifier(this._repository) : super([]) {
    refresh();
  }

  void refresh() {
    state = _repository.getCartItems();
  }

  void add(CartItem item) {
    _repository.addCartItem(item);
    refresh();
  }

  void remove(int productId) {
    _repository.removeCartItem(productId);
    refresh();
  }

  void incrementQty(int productId) {
    final CartItem? item = _repository.existenceCheck(productId);

    if (item != null) {
      item.productQty++;
      _repository.updateCartItem(item);
      refresh();
    }
  }

  void decrementQty(int productId) {
    final CartItem? item = _repository.existenceCheck(productId);

    if (item != null) {
      if (item.productQty > 1) {
        item.productQty--;
        _repository.updateCartItem(item);
      } else {
        remove(productId);
      }
      refresh();
    }
  }

  void removeAll() {
    _repository.removeAllCartItems();
    refresh();
  }
}

final cartRepositoryProvider = Provider<CartRepository>((ref) {
  return CartRepository();
});

final cartItemsProvider =
    StateNotifierProvider<CartItemsNotifier, List<CartItem>>((ref) {
      final repository = ref.watch(cartRepositoryProvider);
      return CartItemsNotifier(repository);
    });
