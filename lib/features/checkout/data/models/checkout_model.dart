import 'package:aura/features/checkout/domain/entities/checkout_entity.dart';
import 'sub_models/checkout_payment_summary_model.dart';
import 'sub_models/checkout_step_model.dart';
import 'sub_models/delivery_method_model.dart';
import 'sub_models/shipping_address_model.dart';

class CheckoutModel extends CheckoutEntity {
  const CheckoutModel({
    required CheckoutStepModel super.step,
    required List<ShippingAddressModel> super.addresses,
    required super.selectedAddressId,
    required List<DeliveryMethodModel> super.deliveryMethods,
    required super.selectedDeliveryMethodId,
    super.deliveryNotes,
    super.appliedPasscode,
    required CheckoutPaymentSummaryModel super.paymentSummary,
  });

  factory CheckoutModel.fromJson(Map<String, dynamic> json) {
    return CheckoutModel(
      step: CheckoutStepModel.fromJson(
        json['step'] as Map<String, dynamic>? ?? {},
      ),
      addresses: (json['addresses'] as List<dynamic>?)
              ?.map((item) =>
                  ShippingAddressModel.fromJson(item as Map<String, dynamic>))
              .toList() ??
          const [],
      selectedAddressId:
          (json['selected_address_id'] ?? json['selectedAddressId']) as String? ?? '1',
      deliveryMethods: (json['delivery_methods'] ?? json['deliveryMethods'] as List<dynamic>?)
              ?.map((item) =>
                  DeliveryMethodModel.fromJson(item as Map<String, dynamic>))
              .toList() ??
          const [],
      selectedDeliveryMethodId: (json['selected_delivery_method_id'] ??
              json['selectedDeliveryMethodId']) as String? ??
          '1',
      deliveryNotes: (json['delivery_notes'] ?? json['deliveryNotes']) as String?,
      appliedPasscode:
          (json['applied_passcode'] ?? json['appliedPasscode']) as String?,
      paymentSummary: CheckoutPaymentSummaryModel.fromJson(
        (json['payment_summary'] ?? json['paymentSummary']) as Map<String, dynamic>? ?? {},
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'step': (step as CheckoutStepModel).toJson(),
      'addresses':
          addresses.map((item) => (item as ShippingAddressModel).toJson()).toList(),
      'selected_address_id': selectedAddressId,
      'delivery_methods': deliveryMethods
          .map((item) => (item as DeliveryMethodModel).toJson())
          .toList(),
      'selected_delivery_method_id': selectedDeliveryMethodId,
      'delivery_notes': deliveryNotes,
      'applied_passcode': appliedPasscode,
      'payment_summary':
          (paymentSummary as CheckoutPaymentSummaryModel).toJson(),
    };
  }
}
