import 'package:aura/features/checkout/domain/entities/sub_entities/delivery_method_entity.dart';

class DeliveryMethodModel extends DeliveryMethodEntity {
  const DeliveryMethodModel({
    required super.id,
    required super.title,
    required super.description,
    required super.eta,
    required super.price,
    super.vipPill,
    super.originalPrice,
    super.subPrice,
    super.isSelected = false,
  });

  factory DeliveryMethodModel.fromJson(Map<String, dynamic> json) {
    return DeliveryMethodModel(
      id: json['id']?.toString() ?? '',
      title: json['title'] as String? ?? '',
      description: json['description'] as String? ?? '',
      eta: json['eta'] as String? ?? '',
      price: json['price'] as String? ?? 'Free',
      vipPill: (json['vip_pill'] ?? json['vipPill']) as String?,
      originalPrice: (json['original_price'] ?? json['originalPrice']) as String?,
      subPrice: (json['sub_price'] ?? json['subPrice']) as String?,
      isSelected: (json['is_selected'] ?? json['isSelected']) as bool? ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'eta': eta,
      'price': price,
      'vip_pill': vipPill,
      'original_price': originalPrice,
      'sub_price': subPrice,
      'is_selected': isSelected,
    };
  }
}
