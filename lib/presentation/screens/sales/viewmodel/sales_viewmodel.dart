import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pos2/domain/entities/cart_item_entity.dart';
import 'package:pos2/domain/entities/product_entity.dart';
import 'package:pos2/domain/repositories/cart_repository.dart';
import 'package:pos2/presentation/providers/cart/cart_items_provider.dart';

class SalesViewModel extends AutoDisposeNotifier<Map<int, int>> {
  late final CartRepository _cartRepository;

  @override
  Map<int, int> build() {
    _cartRepository = ref.watch(cartRepositoryProvider);
    return {};
  }

  int getCounter(int productId) {
    return state[productId] ?? 0;
  }

  void incrementCounter(int productId) {
    state = {...state, productId: (state[productId] ?? 0) + 1};
  }

  void decrementCounter(int productId) {
    final int current = state[productId] ?? 0;
    if (current > 0) {
      state = {...state, productId: current - 1};
    }
  }

  void addToCart(Product product) {
    final int count = state[product.id] ?? 0;
    if (count == 0) return;

    final CartItem item = CartItem(
      productId: product.id,
      productName: product.name,
      productPrice: product.price,
      productStock: product.stock,
      productQty: count,
    );

    ref.read(cartItemsProvider.notifier).add(item);
  }
}
