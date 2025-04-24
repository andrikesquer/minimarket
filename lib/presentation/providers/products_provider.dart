import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pos2/domain/entities/entities.dart';
import 'package:pos2/main.dart';

part 'products_provider.g.dart';

@riverpod
class AddingProduct extends _$AddingProduct {
  @override
  bool build() => false;

  void toggleAddProduct() {
    state = !state;
  }
}

@riverpod
class EditingProduct extends _$EditingProduct {
  @override
  bool build() => false;

  void toggleEditProduct() {
    state = !state;
  }
}

class ProductListNotifier extends StateNotifier<List<Product>> {
  ProductListNotifier() : super(objectbox.getAllProducts());

  void refresh() {
    state = objectbox.getAllProducts();
  }

  void delete(int id) {
    objectbox.deleteProduct(id);
    refresh();
  }
}

final productsProvider =
    StateNotifierProvider<ProductListNotifier, List<Product>>((ref) {
      return ProductListNotifier();
    });

final selectedProductProvider = StateProvider<Product?>((ref) {
  return null;
});
