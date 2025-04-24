import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pos2/presentation/screens/sales/viewmodel/sales_viewmodel.dart';

final salesViewModelProvider = NotifierProvider.autoDispose<SalesViewModel, Map<int, int>>(
  SalesViewModel.new,
);
