import 'package:objectbox/objectbox.dart';

@Entity()
class Product {
  @Id()
  int id;

  String name;

  double price;

  int stock;

  Product({
    this.id = 0,
    required this.name,
    required this.price,
    required this.stock,
  });
}
