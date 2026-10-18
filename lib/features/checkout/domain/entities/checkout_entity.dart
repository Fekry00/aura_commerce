import 'sub_entities/checkout_payment_summary_entity.dart';
import 'sub_entities/checkout_step_entity.dart';
import 'sub_entities/delivery_method_entity.dart';
import 'sub_entities/shipping_address_entity.dart';

class CheckoutEntity {
  const CheckoutEntity({
    required this.step,
    required this.addresses,
    required this.selectedAddressId,
    required this.deliveryMethods,
    required this.selectedDeliveryMethodId,
    this.deliveryNotes,
    this.appliedPasscode,
    required this.paymentSummary,
  });

  final CheckoutStepEntity step;
  final List<ShippingAddressEntity> addresses;
  final String selectedAddressId;
  final List<DeliveryMethodEntity> deliveryMethods;
  final String selectedDeliveryMethodId;
  final String? deliveryNotes;
  final String? appliedPasscode;
  final CheckoutPaymentSummaryEntity paymentSummary;
}
