import 'package:aura/features/checkout/domain/entities/checkout_entity.dart';
import 'package:aura/features/orders/domain/entities/order_entity.dart';

abstract class CheckoutState {
  final String selectedPaymentMethod;
  final int selectedDeliveryMethodIndex;
  final int activeStepIndex;
  final String? selectedShippingAddress;
  final String? recipientPhone;
  final String? appliedPasscode;

  const CheckoutState({
    this.selectedPaymentMethod = 'cod',
    this.selectedDeliveryMethodIndex = 0,
    this.activeStepIndex = 1,
    this.selectedShippingAddress,
    this.recipientPhone,
    this.appliedPasscode,
  });
}

class CheckoutInitialState extends CheckoutState {
  const CheckoutInitialState({
    super.selectedPaymentMethod = 'cod',
    super.selectedDeliveryMethodIndex = 0,
    super.activeStepIndex = 1,
    super.selectedShippingAddress,
    super.recipientPhone,
    super.appliedPasscode,
  });
}

class CheckoutLoadingState extends CheckoutState {
  const CheckoutLoadingState({
    super.selectedPaymentMethod,
    super.selectedDeliveryMethodIndex,
    super.activeStepIndex,
    super.selectedShippingAddress,
    super.recipientPhone,
    super.appliedPasscode,
  });
}

class CheckoutFlowUpdatedState extends CheckoutState {
  const CheckoutFlowUpdatedState({
    super.selectedPaymentMethod,
    super.selectedDeliveryMethodIndex,
    super.activeStepIndex,
    super.selectedShippingAddress,
    super.recipientPhone,
    super.appliedPasscode,
  });
}

class CheckoutSuccessState extends CheckoutState {
  const CheckoutSuccessState({
    required this.checkout,
    super.selectedPaymentMethod,
    super.selectedDeliveryMethodIndex,
    super.activeStepIndex,
    super.selectedShippingAddress,
    super.recipientPhone,
    super.appliedPasscode,
  });

  final CheckoutEntity checkout;
}

class CheckoutOrderPlacedState extends CheckoutState {
  const CheckoutOrderPlacedState({
    required this.order,
    super.selectedPaymentMethod,
    super.selectedDeliveryMethodIndex,
    super.activeStepIndex,
    super.selectedShippingAddress,
    super.recipientPhone,
    super.appliedPasscode,
  });

  final OrderEntity order;
}

class CheckoutErrorState extends CheckoutState {
  const CheckoutErrorState({
    required this.message,
    super.selectedPaymentMethod,
    super.selectedDeliveryMethodIndex,
    super.activeStepIndex,
    super.selectedShippingAddress,
    super.recipientPhone,
    super.appliedPasscode,
  });

  final String message;
}
