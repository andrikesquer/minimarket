import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pos2/domain/entities/product_entity.dart';
import 'package:pos2/domain/repositories/product_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'products_provider.g.dart';

@riverpod
class AddingProduct extends _$AddingProduct {
  @override
  bool build() => false;

  void toggleAddProduct() => state = !state;
}

@riverpod
class EditingProduct extends _$EditingProduct {
  @override
  bool build() => false;

  void toggleEditProduct() => state = !state;
}

final productRepositoryProvider = Provider<ProductRepository>((ref) {
  return ProductRepository();
});

final productsProvider =
    StateNotifierProvider<ProductListNotifier, List<Product>>((ref) {
      final repository = ref.watch(productRepositoryProvider);
      return ProductListNotifier(repository);
    });

final selectedProductProvider = StateProvider<Product?>((ref) {
  return null;
});

class ProductListNotifier extends StateNotifier<List<Product>> {
  final ProductRepository _repository;

  ProductListNotifier(this._repository) : super([]) {
    refresh();
  }

  void refresh() {
    state = _repository.getAllProducts();
  }

  void add(Product product) {
    _repository.addProduct(product);
  }

  void delete(int id) {
    _repository.deleteProduct(id);
    refresh();
  }
}
