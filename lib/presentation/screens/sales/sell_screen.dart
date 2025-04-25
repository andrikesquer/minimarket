import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pos2/presentation/providers/products_provider.dart';
import 'package:pos2/presentation/screens/sales/widgets/sales.dart';
import 'package:pos2/presentation/screens/sales/widgets/sell/sell_app_bar.dart';

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
