import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';
import 'package:pos2/domain/entities/entities.dart';
import 'package:pos2/domain/entities/shop_order_entity.dart';

import 'objectbox.g.dart';

class ObjectBox {
  late final Store _store;

  late final Box<Product> productBox;

  late final Box<CartItem> cartBox;

  late final Box<ShopOrder> shopOrderBox;

  ObjectBox._create(this._store) {
    productBox = Box<Product>(_store);
    cartBox = Box<CartItem>(_store);
    shopOrderBox = Box<ShopOrder>(_store);
  }

  static Future<ObjectBox> create() async {
    final docsDir = await getApplicationDocumentsDirectory();
    final store = await openStore(
      directory: path.join(docsDir.path, "objectbox"),
    );
    return ObjectBox._create(store);
  }

  // PRODUCTOS

  int addProduct(Product product) {
    return productBox.put(product);
  }

  List<Product> getAllProducts() {
    return productBox.getAll();
  }

  Product? getProduct(int id) {
    return productBox.get(id);
  }

  void updateProduct(Product product) {
    productBox.put(product);
  }

  bool deleteProduct(int id) {
    return productBox.remove(id);
  }

  // CARRITO

  List<CartItem> getCartItems(){
    return cartBox.getAll();
  }

  CartItem? existenceCheck(int productId) {
    return cartBox
        .query(CartItem_.productId.equals(productId))
        .build()
        .findFirst();
  }

  void addCartItem(CartItem item) {
    final exists = existenceCheck(item.productId);

    if (exists != null) {
      exists.productQty += item.productQty;
      cartBox.put(exists);
    } else {
      cartBox.put(item);
    }
  }

  void removeCartItem(int productId) {
    final exists = existenceCheck(productId);

    if (exists != null) cartBox.remove(exists.id);
  }

  void removeAll() {
    cartBox.removeAll();
  }

  // ORDENES

  List<ShopOrder> getAllOrders() {
    return shopOrderBox.getAll();
  }

  void saveOrder(ShopOrder order) {
    shopOrderBox.put(order);
  }
}
