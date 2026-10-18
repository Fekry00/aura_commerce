import 'package:aura/features/cart/domain/entities/sub_entities/cart_item_entity.dart';

class CartItemModel extends CartItemEntity {
  const CartItemModel({
    required super.id,
    required super.category,
    required super.title,
    required super.subtitle,
    required super.price,
    required super.quantity,
    required super.imageUrl,
  });

  factory CartItemModel.fromJson(Map<String, dynamic> json) {
    return CartItemModel(
      id: json['id']?.toString() ?? '',
      category: json['category'] as String? ?? '',
      title: json['title'] as String? ?? '',
      subtitle: json['subtitle'] as String? ?? '',
      price: ((json['price'] ?? json['unit_price'] ?? json['unitPrice'])
              as num?)
          ?.toDouble() ??
          0.0,
      quantity: (json['quantity'] as num?)?.toInt() ?? 1,
      imageUrl: (json['image_url'] ?? json['imageUrl']) as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'category': category,
      'title': title,
      'subtitle': subtitle,
      'price': price,
      'quantity': quantity,
      'image_url': imageUrl,
    };
  }
}
