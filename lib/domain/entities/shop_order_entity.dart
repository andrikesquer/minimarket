import 'package:objectbox/objectbox.dart';
import 'entities.dart';

@Entity()
class ShopOrder {
  int id;

  List<int> products;

  List<int> quantities;

  List<double> subtotals;

  @Property(type: PropertyType.date)
  DateTime date;

  double total;

  ShopOrder({
    this.id = 0,
    required this.products,
    required this.quantities,
    required this.subtotals,
    required this.date,
    required this.total,
  });

  final product = ToMany<Product>();
}
