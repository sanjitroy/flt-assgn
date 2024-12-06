import 'package:purr/home/core/types/menu_item.type.dart';

class MockMenuService {
  Future<List<MenuItem>> fetchMenu() async {
    await Future.delayed(const Duration(seconds: 2)); // Simulates network delay
    return MockData().mockMenuItems;
  }
}

class MockData {
  List<MenuItem> mockMenuItems = [
    MenuItem(
      id: 1,
      name: "Poke with chicken",
      description:
          "Famous Hawaiian dish. Rice pillow with tender chicken breast, mushrooms, lettuce, cherry tomatoes, seaweed, and corn, with unagi sauce.",
      price: 12.99,
      nutrients: Nutrients(
        kcal: 235,
        grams: 420,
        protein: 21,
        fats: 19,
        carbs: 65,
      ),
      imageUrl: 'assets/images/Food-Plate.png',
    ),
    MenuItem(
      id: 2,
      name: "Margherita Pizza",
      description:
          "Classic Italian pizza with fresh tomatoes, mozzarella cheese, and basil leaves.",
      price: 10.49,
      nutrients: Nutrients(
        kcal: 300,
        grams: 500,
        protein: 18,
        fats: 12,
        carbs: 55,
      ),
      imageUrl: 'assets/images/Pizza.png',
    ),
    MenuItem(
      id: 3,
      name: "Pasta Carbonara",
      description:
          "Creamy pasta with bacon, Parmesan cheese, egg yolk, and black pepper.",
      price: 14.25,
      nutrients: Nutrients(
        kcal: 450,
        grams: 400,
        protein: 25,
        fats: 22,
        carbs: 60,
      ),
      imageUrl: 'assets/images/Napoli-Bread.png',
    ),
    MenuItem(
      id: 4,
      name: "Caesar Salad",
      description:
          "Crisp romaine lettuce, grilled chicken, croutons, Parmesan, and Caesar dressing.",
      price: 8.99,
      nutrients: Nutrients(
        kcal: 200,
        grams: 350,
        protein: 15,
        fats: 10,
        carbs: 20,
      ),
      imageUrl: 'assets/images/Salad.png',
    ),
    MenuItem(
      id: 5,
      name: "Salmon Sashimi",
      description:
          "Freshly sliced raw salmon served with soy sauce and wasabi.",
      price: 18.50,
      nutrients: Nutrients(
        kcal: 280,
        grams: 300,
        protein: 30,
        fats: 15,
        carbs: 5,
      ),
      imageUrl: 'assets/images/Fruits-Plate.png',
    ),
    MenuItem(
      id: 6,
      name: "Beef Burger",
      description:
          "Juicy beef patty with cheddar cheese, lettuce, tomato, pickles, and special sauce.",
      price: 11.75,
      nutrients: Nutrients(
        kcal: 520,
        grams: 350,
        protein: 35,
        fats: 28,
        carbs: 45,
      ),
      imageUrl: 'assets/images/Bread-Slices.png',
    ),
    MenuItem(
      id: 7,
      name: "Vegetable Stir Fry",
      description:
          "A medley of fresh vegetables stir-fried in a savory soy garlic sauce.",
      price: 9.99,
      nutrients: Nutrients(
        kcal: 180,
        grams: 300,
        protein: 10,
        fats: 8,
        carbs: 25,
      ),
      imageUrl: 'assets/images/Food-Plate.png',
    ),
    MenuItem(
      id: 8,
      name: "Tuna Melt Sandwich",
      description:
          "Grilled sandwich with tuna, melted cheese, and tomato slices.",
      price: 7.95,
      nutrients: Nutrients(
        kcal: 340,
        grams: 250,
        protein: 20,
        fats: 15,
        carbs: 30,
      ),
      imageUrl: 'assets/images/Tomato.png',
    ),
    MenuItem(
      id: 9,
      name: "Mushroom Risotto",
      description:
          "Creamy Arborio rice cooked with assorted mushrooms and Parmesan.",
      price: 13.50,
      nutrients: Nutrients(
        kcal: 400,
        grams: 400,
        protein: 16,
        fats: 20,
        carbs: 50,
      ),
      imageUrl: 'assets/images/Leaves.png',
    ),
    MenuItem(
      id: 10,
      name: "Chicken Tikka Masala",
      description:
          "Grilled chicken chunks in a spicy, creamy tomato-based sauce, served with rice.",
      price: 15.20,
      nutrients: Nutrients(
        kcal: 460,
        grams: 450,
        protein: 35,
        fats: 25,
        carbs: 45,
      ),
      imageUrl: 'assets/images/Indian-Chutney.png',
    ),
    MenuItem(
      id: 11,
      name: "Chocolate Lava Cake",
      description:
          "Warm chocolate cake with a gooey molten center, served with vanilla ice cream.",
      price: 6.75,
      nutrients: Nutrients(
        kcal: 380,
        grams: 180,
        protein: 8,
        fats: 22,
        carbs: 45,
      ),
      imageUrl: 'assets/images/Dessert.png',
    ),
  ];
}
