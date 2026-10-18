import 'package:aura/features/checkout/domain/entities/checkout_entity.dart';

abstract class CheckoutState {
  const CheckoutState();
}

class CheckoutInitialState extends CheckoutState {
  const CheckoutInitialState();
}

class CheckoutLoadingState extends CheckoutState {
  const CheckoutLoadingState();
}

class CheckoutSuccessState extends CheckoutState {
  const CheckoutSuccessState({required this.checkout});

  final CheckoutEntity checkout;
}

class CheckoutOrderPlacedState extends CheckoutState {
  const CheckoutOrderPlacedState({required this.orderId});

  final String orderId;
}

class CheckoutErrorState extends CheckoutState {
  const CheckoutErrorState({required this.message});

  final String message;
}
