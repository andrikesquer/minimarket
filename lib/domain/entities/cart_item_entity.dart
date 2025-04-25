import 'package:objectbox/objectbox.dart';
import 'package:pos2/domain/entities/shop_order_entity.dart';

@Entity()
class CartItem {
  @Id()
  int id;

  int productId;

  String productName;

  double productPrice;

  int productStock;

  int productQty;


  final shopOrder = ToOne<ShopOrder>();

  CartItem({
    this.id = 0,
    required this.productId,
    required this.productName,
    required this.productPrice,
    required this.productStock,
    required this.productQty,
  });

  double get subtotal => productPrice * productQty;
}
