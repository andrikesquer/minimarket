import 'package:pos2/domain/entities/product_entity.dart';
import 'package:pos2/data/data_sources/objectbox_database.dart';

class ProductRepository {
  final _productBox = ObjectBoxDatabase.instance.productBox;

  void addProduct(Product product) {
    _productBox.put(product);
  }

  List<Product> getAllProducts() {
    return _productBox.getAll();
  }

  Product? getProduct(int id) {
    return _productBox.get(id);
  }

  void updateProduct(Product product) {
    _productBox.put(product);
  }

  bool deleteProduct(int id) {
    return _productBox.remove(id);
  }
}
