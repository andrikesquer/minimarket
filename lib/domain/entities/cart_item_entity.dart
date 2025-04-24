import 'package:objectbox/objectbox.dart';

@Entity()
class CartItem {
  @Id()
  int id;

  int productId;

  String productName;

  double productPrice;

  int productQuantity;

  CartItem({
    this.id = 0,
    required this.productId,
    required this.productName,
    required this.productPrice,
    required this.productQuantity,
  });

  double get subtotal => productPrice * productQuantity;
}
