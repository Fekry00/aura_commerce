import 'package:aura/features/checkout/domain/entities/sub_entities/shipping_address_entity.dart';

class ShippingAddressModel extends ShippingAddressEntity {
  const ShippingAddressModel({
    required super.id,
    required super.label,
    required super.recipient,
    required super.phone,
    required super.address,
    super.isDefault = false,
  });

  factory ShippingAddressModel.fromJson(Map<String, dynamic> json) {
    return ShippingAddressModel(
      id: json['id']?.toString() ?? '',
      label: json['label'] as String? ?? 'Home',
      recipient: json['recipient'] as String? ?? '',
      phone: json['phone'] as String? ?? '',
      address: json['address'] as String? ?? '',
      isDefault: (json['is_default'] ?? json['isDefault']) as bool? ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'label': label,
      'recipient': recipient,
      'phone': phone,
      'address': address,
      'is_default': isDefault,
    };
  }
}
