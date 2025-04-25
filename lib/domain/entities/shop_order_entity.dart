import 'package:objectbox/objectbox.dart';
import 'cart_item_entity.dart';

@Entity()
class ShopOrder {
  @Id()
  int id = 0;

  String date;
  double total;

  @Backlink('shopOrder')
  final items = ToMany<CartItem>();

  ShopOrder({required this.date, required this.total});
}
