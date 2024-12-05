class MenuItem {
  final String id;
  final String name;
  final double price;
  final String description;
  final String category;
  final bool isAvailable;
  final List<String?> imageUrl;

  MenuItem({
    required this.id,
    required this.name,
    required this.price,
    required this.description,
    required this.category,
    this.isAvailable = true,
    this.imageUrl = const [],
  });

  MenuItem copyWith({
    String? id,
    String? name,
    double? price,
    String? description,
    String? category,
    bool? isAvailable,
    List<String?>? imageUrl,
  }) {
    return MenuItem(
      id: id ?? this.id,
      name: name ?? this.name,
      price: price ?? this.price,
      description: description ?? this.description,
      category: category ?? this.category,
      isAvailable: isAvailable ?? this.isAvailable,
      imageUrl: imageUrl ?? this.imageUrl,
    );
  }
}
