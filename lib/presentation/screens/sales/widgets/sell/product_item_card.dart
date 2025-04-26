import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pos2/domain/entities/product_entity.dart';
import 'package:pos2/presentation/providers/sales_view_model_provider.dart';

class ProductItemCard extends ConsumerWidget {
  final Product product;

  const ProductItemCard({super.key, required this.product});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final salesState = ref.watch(salesViewModelProvider);
    final viewModel = ref.read(salesViewModelProvider.notifier);

    final int counter = salesState[product.id] ?? 0;

    return Card.outlined(
      elevation: 0,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        spacing: 10,
        children: [
          Text(product.name, style: TextStyle(fontWeight: FontWeight.w600)),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text('\$${product.price}'),
              Text('Stock: ${product.stock}'),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: () {
                      viewModel.decrementCounter(product.id);
                    },
                    icon: Icon(Icons.remove),
                  ),
                  Text('$counter'),
                  IconButton(
                    onPressed: () {
                      if (product.stock > counter) {
                        viewModel.incrementCounter(product.id);
                      }
                    },
                    icon: Icon(Icons.add),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                    onPressed: () => viewModel.addToCart(product),
                    icon: Icon(Icons.shopping_cart_rounded),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
