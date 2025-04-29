import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:pos2/presentation/providers/sales_report_provider.dart';

class SalesReportAppBar extends ConsumerWidget implements PreferredSizeWidget {
  const SalesReportAppBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AppBar(
      leading: IconButton(
        icon: Icon(Icons.arrow_back),
        onPressed: () {
          context.go('/reports');
        },
      ),
      title: Text('Reporte de ventas'),
      actions: [
        IconButton(
          icon: Icon(Icons.filter_alt),
          onPressed: () {
            ref.watch(isFilteringProvider.notifier).toggleFiltering();
          },
        ),
        IconButton(
          icon: Icon(Icons.home),
          onPressed: () {
            context.go('/:email');
          },
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
