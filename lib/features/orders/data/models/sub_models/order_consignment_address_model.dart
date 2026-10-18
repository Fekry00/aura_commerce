import 'package:aura/features/orders/domain/entities/sub_entities/order_consignment_address_entity.dart';

class OrderConsignmentAddressModel extends OrderConsignmentAddressEntity {
  const OrderConsignmentAddressModel({
    required super.recipientName,
    required super.addressType,
    required super.addressLine,
    required super.cityStateZip,
    required super.phoneNumber,
    required super.conciergeProtocol,
  });

  factory OrderConsignmentAddressModel.fromJson(Map<String, dynamic> json) {
    return OrderConsignmentAddressModel(
      recipientName: (json['recipient_name'] ?? json['recipientName']) as String? ?? '',
      addressType: (json['address_type'] ?? json['addressType']) as String? ?? 'Default: Residence',
      addressLine: (json['address_line'] ?? json['addressLine']) as String? ?? '',
      cityStateZip: (json['city_state_zip'] ?? json['cityStateZip']) as String? ?? '',
      phoneNumber: (json['phone_number'] ?? json['phoneNumber']) as String? ?? '',
      conciergeProtocol: (json['concierge_protocol'] ?? json['conciergeProtocol']) as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'recipient_name': recipientName,
      'address_type': addressType,
      'address_line': addressLine,
      'city_state_zip': cityStateZip,
      'phone_number': phoneNumber,
      'concierge_protocol': conciergeProtocol,
    };
  }
}
