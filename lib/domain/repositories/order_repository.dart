import 'package:pos2/domain/entities/shop_order_entity.dart';
import 'package:pos2/data/data_sources/objectbox_database.dart';

class OrderRepository {
  final _orderBox = ObjectBoxDatabase.instance.shopOrderBox;

  List<ShopOrder> getAllOrders() {
    return _orderBox.getAll();
  }

  void addOrder(ShopOrder order) {
    _orderBox.put(order);
  }
}
