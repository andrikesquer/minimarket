import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pos2/domain/repositories/cart_repository.dart';
import 'package:pos2/main.dart';

final cartRepositoryProvider = Provider<CartRepository>((ref) {
  final box = objectbox.cartBox;
  return CartRepository(box);
});
