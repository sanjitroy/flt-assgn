class MenuItemDto {
  final int id;
  final String name;
  final String description;
  final double price;
  final NutrientsDto nutrients;
  final String imageUrl;

  MenuItemDto({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.nutrients,
    required this.imageUrl,
  });

  factory MenuItemDto.fromJson(Map<String, dynamic> json) {
    return MenuItemDto(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      price: (json['price'] as num).toDouble(),
      nutrients: NutrientsDto.fromJson(json['nutrients']),
      imageUrl: json['imageUrl'],
    );
  }
}

class NutrientsDto {
  final int kcal;
  final int grams;
  final int protein;
  final int fats;
  final int carbs;

  NutrientsDto({
    required this.kcal,
    required this.grams,
    required this.protein,
    required this.fats,
    required this.carbs,
  });

  factory NutrientsDto.fromJson(Map<String, dynamic> json) {
    return NutrientsDto(
      kcal: json['kcal'],
      grams: json['grams'],
      protein: json['protein'],
      fats: json['fats'],
      carbs: json['carbs'],
    );
  }
}
