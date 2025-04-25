import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pos2/presentation/providers/cart/cart_items_provider.dart';
import 'package:pos2/presentation/screens/cart/widgets/sell_button.dart';
import 'package:pos2/presentation/screens/cart/widgets/cart.dart';

class Cart extends ConsumerWidget {
  const Cart({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final items = ref.watch(cartItemsProvider);

    return SafeArea(
      child: Scaffold(
        appBar: CartAppBar(),
        body: CartItemsList(items: items),
        bottomNavigationBar: SellButton(items: items),
      ),
    );
  }
}
