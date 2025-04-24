import 'package:pos2/data/datasource/objectbox.g.dart';
import 'package:pos2/domain/entities/entities.dart';

class CartRepository {
  final Box<CartItem> cartBox;

  CartRepository(this.cartBox);

  List<CartItem> getAll() => cartBox.getAll();

  CartItem? existenceCheck(int productId) {
    final check =
        cartBox
            .query(CartItem_.productId.equals(productId))
            .build()
            .findFirst();
    return check;
  }

  void manageAddProduct(CartItem item) {
    final exists = existenceCheck(item.productId);

    if (exists == null) {
      print('Agregando...');
      cartBox.put(item);
    } else {
      print('Actualizando...');
      exists.productQuantity += item.productQuantity;
      cartBox.put(exists);
    }
  }

  void manageRemoveProduct(int productId) {
    final exists = existenceCheck(productId);

    if (exists != null) {
      cartBox.remove(productId);
    }
  }

  void removeAll() {
    cartBox.removeAll();
  }
}
