import 'package:objectbox/objectbox.dart';
import 'package:pos2/domain/entities/entities.dart';

class CartRepository {
  final Box<CartItem> cartBox;

  CartRepository(this.cartBox);

  List<CartItem> getAll() => cartBox.getAll();
}
