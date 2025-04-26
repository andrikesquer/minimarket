import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';
import 'objectbox.g.dart';
import 'package:pos2/domain/entities/product_entity.dart';
import 'package:pos2/domain/entities/cart_item_entity.dart';
import 'package:pos2/domain/entities/shop_order_entity.dart';

class ObjectBoxDatabase {
  static ObjectBoxDatabase? _instance;

  late final Store _store;

  late final Box<Product> productBox;

  late final Box<CartItem> cartBox;

  late final Box<ShopOrder> shopOrderBox;

  ObjectBoxDatabase._create(this._store) {
    productBox = Box<Product>(_store);
    cartBox = Box<CartItem>(_store);
    shopOrderBox = Box<ShopOrder>(_store);
  }

  static Future<ObjectBoxDatabase> create() async {
    final docsDir = await getApplicationDocumentsDirectory();
    final store = await openStore(
      directory: path.join(docsDir.path, "objectbox"),
    );
    _instance = ObjectBoxDatabase._create(store);
    return _instance!;
  }

  static ObjectBoxDatabase get instance {
    if (_instance == null) {
      throw Exception(
        'ObjectBoxDatabase no ha sido inicializada. Llama a create() primero.',
      );
    }
    return _instance!;
  }
}
