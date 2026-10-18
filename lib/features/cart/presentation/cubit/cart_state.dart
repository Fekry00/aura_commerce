import 'package:aura/features/cart/domain/entities/cart_entity.dart';

abstract class CartState {
  const CartState();
}

class CartInitialState extends CartState {
  const CartInitialState();
}

class CartLoadingState extends CartState {
  const CartLoadingState();
}

class CartSuccessState extends CartState {
  const CartSuccessState({required this.cart});

  final CartEntity cart;
}

class CartErrorState extends CartState {
  const CartErrorState({required this.message});

  final String message;
}
