import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pos2/domain/entities/product_entity.dart';
import 'product_item_card.dart';

class ProductGrid extends ConsumerWidget {
  final List<Product> products;
  const ProductGrid({super.key, required this.products});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GridView.builder(
      padding: const EdgeInsets.all(15),
      itemCount: products.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 5,
        crossAxisSpacing: 5,
      ),
      itemBuilder: (BuildContext context, int index) {
        return ProductItemCard(product: products[index]);
      },
    );
  }
}
