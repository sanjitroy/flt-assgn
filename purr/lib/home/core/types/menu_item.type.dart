import 'package:purr/home/data/dtos/menu_item.dto.dart';

class MenuItem {
  final int id;
  final String name;
  final String description;
  final double price;
  final Nutrients nutrients;
  final String imageUrl;

  MenuItem({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.nutrients,
    required this.imageUrl,
  });

  factory MenuItem.fromDto(MenuItemDto dto) {
    return MenuItem(
      id: dto.id,
      name: dto.name,
      description: dto.description,
      price: dto.price,
      nutrients: Nutrients.fromDto(dto.nutrients),
      imageUrl: dto.imageUrl,
    );
  }
}

class Nutrients {
  final int kcal;
  final int grams;
  final int protein;
  final int fats;
  final int carbs;

  Nutrients({
    required this.kcal,
    required this.grams,
    required this.protein,
    required this.fats,
    required this.carbs,
  });

  factory Nutrients.fromDto(NutrientsDto dto) {
    return Nutrients(
      kcal: dto.kcal,
      grams: dto.grams,
      protein: dto.protein,
      fats: dto.fats,
      carbs: dto.carbs,
    );
  }
}
