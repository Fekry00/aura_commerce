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
  const CartSuccessState({required this.cart, this.userFeedback});

  final CartEntity cart;
  final String? userFeedback;
}

class CartActionSuccessState extends CartSuccessState {
  const CartActionSuccessState({
    required super.cart,
    required this.message,
  }) : super(userFeedback: message);

  final String message;
}

class CartNavigateToCheckoutState extends CartSuccessState {
  const CartNavigateToCheckoutState({required super.cart});
}

class CartErrorState extends CartState {
  const CartErrorState({required this.message});

  final String message;
}

class CartInfoMessageState extends CartState {
  const CartInfoMessageState({required this.message});

  final String message;
}
