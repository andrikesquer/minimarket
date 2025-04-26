import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pos2/presentation/providers/products/products_provider.dart';
import 'package:pos2/presentation/screens/sales/widgets/sell/sell_app_bar.dart';
import 'package:pos2/presentation/screens/sales/widgets/sell/product_grid.dart';

class SellScreen extends ConsumerWidget {
  const SellScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final products = ref.watch(productsProvider);

    return SafeArea(
      child: Scaffold(
        appBar: SellAppBar(),
        body: ProductGrid(products: products),
      ),
    );
  }
}
