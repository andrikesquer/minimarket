import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pos2/presentation/providers/orders_provider.dart';
import 'package:pos2/presentation/screens/sales/widgets/sales_history/orders_list.dart';
import 'package:pos2/presentation/screens/sales/widgets/sales_history/sales_history_app_bar.dart';

class SalesHistory extends ConsumerWidget {
  const SalesHistory({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final orders = ref.watch(ordersProvider);

    return SafeArea(
      child: Scaffold(
        appBar: SalesHistoryAppBar(),
        body: OrdersList(orders: orders),
      ),
    );
  }
}
