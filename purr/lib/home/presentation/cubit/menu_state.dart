import 'package:equatable/equatable.dart';
import 'package:purr/home/core/types/menu_item.type.dart';

class CartItem {
  final MenuItem menuItem;
  final int quantity;

  CartItem({
    required this.menuItem,
    required this.quantity,
  });

  CartItem copyWith({MenuItem? menuItem, int? quantity}) {
    return CartItem(
      menuItem: menuItem ?? this.menuItem,
      quantity: quantity ?? this.quantity,
    );
  }

  @override
  String toString() => 'CartItem(menuItem: $menuItem, quantity: $quantity)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is CartItem &&
        other.menuItem == menuItem &&
        other.quantity == quantity;
  }

  @override
  int get hashCode => menuItem.hashCode ^ quantity.hashCode;
}

class MenuState extends Equatable {
  final List<MenuItem> menuItems;
  final List<CartItem> cart;
  final Map<int, int> tempQuantities;
  final bool isLoading;
  final String? error;

  const MenuState({
    required this.menuItems,
    required this.cart,
    required this.tempQuantities,
    this.isLoading = false,
    this.error,
  });

  MenuState copyWith({
    List<MenuItem>? menuItems,
    List<CartItem>? cart,
    Map<int, int>? tempQuantities,
    bool? isLoading,
    String? error,
  }) {
    return MenuState(
      menuItems: menuItems ?? this.menuItems,
      cart: cart ?? this.cart,
      isLoading: isLoading ?? this.isLoading,
      tempQuantities: tempQuantities ?? this.tempQuantities,
      error: error,
    );
  }

  @override
  List<Object?> get props =>
      [menuItems, cart, tempQuantities, isLoading, error];

  @override
  String toString() =>
      'MenuState(menuItems: $menuItems, cart: $cart, isLoading: $isLoading, error: $error)';
}
