import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:purr/home/core/types/menu_item.type.dart';
import 'package:purr/home/presentation/cubit/menu_state.dart';
import 'package:purr/mocks/mockData.dart';

class MenuCubit extends Cubit<MenuState> {
  MenuCubit()
      : super(MenuState(
          menuItems: [],
          cart: [],
          tempQuantities: {},
        ));

  void loadMenu() async {
    final items = await MockMenuService().fetchMenu();

    emit(
      state.copyWith(menuItems: items, isLoading: false),
    );
  }

  void updateTempQuantity(MenuItem item, int quantity) {
    if (quantity < 1) return;

    final updatedQuantities = Map.of(state.tempQuantities)
      ..[item.id] = quantity;

    emit(state.copyWith(tempQuantities: updatedQuantities));
  }

  void addItemToCart(MenuItem item) {
    final selectedQuantity = state.tempQuantities[item.id] ?? 1;
    final existingCartItem = state.cart.firstWhere(
      (cartItem) => cartItem.menuItem.id == item.id,
      orElse: () => CartItem(menuItem: item, quantity: 0),
    );

    if (existingCartItem.quantity > 0) {
      final updatedCart = state.cart.map((cartItem) {
        if (cartItem.menuItem.id == item.id) {
          return cartItem.copyWith(
              quantity: cartItem.quantity + selectedQuantity);
        }
        return cartItem;
      }).toList();

      emit(state.copyWith(cart: updatedCart));
    } else {
      emit(state.copyWith(cart: [
        ...state.cart,
        CartItem(menuItem: item, quantity: selectedQuantity),
      ]));
    }
  }

  void removeFromCart(MenuItem item) {
    final cart = List<CartItem>.from(state.cart);

    cart.removeWhere((cartItem) => cartItem.menuItem.id == item.id);

    emit(state.copyWith(cart: cart));
  }

  void updateCartItem(MenuItem item, int quantity) {
    if (quantity <= 0) {
      removeFromCart(item);
      return;
    }

    final cart = List<CartItem>.from(state.cart);
    final existingItemIndex =
        cart.indexWhere((cartItem) => cartItem.menuItem.id == item.id);

    if (existingItemIndex != -1) {
      final updatedItem = cart[existingItemIndex].copyWith(quantity: quantity);
      cart[existingItemIndex] = updatedItem;
      emit(state.copyWith(cart: cart));
    }
  }

  double calculateTotalPrice() {
    return state.cart.fold(
      0.0,
      (total, cartItem) =>
          total + (cartItem.menuItem.price * cartItem.quantity),
    );
  }
}
