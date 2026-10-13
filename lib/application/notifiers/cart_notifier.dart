import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/models/cart_item.dart';
import '../../domain/models/product.dart';

class CartNotifier extends Notifier<List<CartItem>> {
  @override
  List<CartItem> build() {
    return [];
  }

  void addProduct(Product product) {
    final index = state.indexWhere(
      (item) => item.product.id == product.id,
    );

    if (index == -1) {
      state = [
        ...state,
        CartItem(
          product: product,
          quantity: 1,
        ),
      ];
      return;
    }

    final updatedState = [...state];

    updatedState[index] = updatedState[index].copyWith(
      quantity: updatedState[index].quantity + 1,
    );

    state = updatedState;
  }

  void removeProduct(Product product) {
    state = state
        .where(
          (item) => item.product.id != product.id,
        )
        .toList();
  }

  void updateQuantity(
    Product product,
    int quantity,
  ) {
    if (quantity <= 0) {
      removeProduct(product);
      return;
    }

    final index = state.indexWhere(
      (item) => item.product.id == product.id,
    );

    if (index == -1) return;

    final updatedState = [...state];

    updatedState[index] = updatedState[index].copyWith(
      quantity: quantity,
    );

    state = updatedState;
  }

  void clearCart() {
    state = [];
  }

  double get totalPrice {
    return state.fold(
      0.0,
      (sum, item) =>
          sum + item.product.price * item.quantity,
    );
  }

  int get totalItems {
    return state.fold(
      0,
      (sum, item) => sum + item.quantity,
    );
  }
}