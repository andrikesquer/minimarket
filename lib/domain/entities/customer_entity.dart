import 'package:objectbox/objectbox.dart';

@Entity()
class Customer {
  int id;
  String email;

  Customer({this.id = 0, required this.email});
}
