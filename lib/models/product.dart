import 'package:uuid/uuid.dart';

final uuid = Uuid();

class Product {
  final String id;
  final String name;
  final double price;

  Product({String? id, required this.name, required this.price}) : id = id ?? uuid.v4();
}