import 'categories.dart';

class Item {
  final String id;
  final String name;
  final int quantity;
  final GrocerryCategory? category;
  Item({
    required this.id,
    required this.name,
    required this.quantity,
    required this.category,
  });
}