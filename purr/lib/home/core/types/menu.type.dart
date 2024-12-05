import 'package:equatable/equatable.dart';
import 'package:purr/home/core/types/menu_item.type.dart';

class Menu extends Equatable {
  final List<MenuItem> items;

  Menu({required this.items});

  // Get item by its ID
  // MenuItem? findItemById(String id) {
  //   return items.firstWhere((item) => item.id == id, orElse: () => null);
  // }

  // Get items by category
  // List<MenuItem> getItemsByCategory(String category) {
  //   return items.where((item) => item.categories.contains(category)).toList();
  // }

  @override
  List<Object> get props => [items];
}