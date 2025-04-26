import 'package:pos2/data/data_sources/objectbox.g.dart';
import 'package:pos2/data/data_sources/objectbox_database.dart';
import 'package:pos2/domain/entities/cart_item_entity.dart';

class CartRepository {
  final _cartBox = ObjectBoxDatabase.instance.cartBox;

  List<CartItem> getCartItems() {
    return _cartBox.getAll();
  }

  CartItem? existenceCheck(int productId) {
    return _cartBox
        .query(CartItem_.productId.equals(productId))
        .build()
        .findFirst();
  }

  void addCartItem(CartItem item) {
    final CartItem? exists = existenceCheck(item.productId);

    if (exists != null) {
      exists.productQty += item.productQty;
      _cartBox.put(exists);
    } else {
      _cartBox.put(item);
    }
  }

  void updateCartItem(CartItem item) {
    _cartBox.put(item);
  }

  void removeCartItem(int productId) {
    final CartItem? exists = existenceCheck(productId);

    if (exists != null) _cartBox.remove(exists.id);
  }

  void removeAllCartItems() {
    _cartBox.removeAll();
  }
}
