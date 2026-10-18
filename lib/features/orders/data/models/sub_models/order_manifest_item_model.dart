import 'package:aura/features/orders/domain/entities/sub_entities/order_manifest_item_entity.dart';

class OrderManifestItemModel extends OrderManifestItemEntity {
  const OrderManifestItemModel({
    required super.id,
    required super.name,
    required super.subtitle,
    required super.quantity,
    required super.price,
    required super.imageUrl,
  });

  factory OrderManifestItemModel.fromJson(Map<String, dynamic> json) {
    return OrderManifestItemModel(
      id: json['id']?.toString() ?? '',
      name: json['name'] as String? ?? '',
      subtitle: json['subtitle'] as String? ?? '',
      quantity: (json['quantity'] as num?)?.toInt() ?? 1,
      price: json['price'] as String? ?? '',
      imageUrl: (json['image_url'] ?? json['imageUrl']) as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'subtitle': subtitle,
      'quantity': quantity,
      'price': price,
      'image_url': imageUrl,
    };
  }
}
