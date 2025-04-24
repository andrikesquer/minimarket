import 'package:flutter_riverpod/flutter_riverpod.dart';

class CounterNotifier extends StateNotifier<int> {
  CounterNotifier() : super(0);

  void increment() {
    state++;
  }

  void decrement() {
    if (state > 0) state--;
  }
}

final counterProvider = StateNotifierProvider.autoDispose
    .family<CounterNotifier, int, int>((ref, productId) {
      return CounterNotifier();
    });
