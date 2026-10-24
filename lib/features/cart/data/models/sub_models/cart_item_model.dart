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
    final productMap = json['product'] is Map<String, dynamic>
        ? json['product'] as Map<String, dynamic>
        : null;

    final titleVal = (productMap?['name'] ?? json['title'] ?? json['name']) as String? ?? '';
    final categoryVal = (productMap?['category'] is Map
            ? productMap!['category']['name']
            : (productMap?['category'] ?? json['category'])) as String? ??
        '';
    final priceVal = ((productMap?['price'] ?? json['price'] ?? json['unit_price'] ?? json['unitPrice']) as num?)?.toDouble() ?? 0.0;
    final imgVal = (productMap?['thumbnailUrl'] ??
            productMap?['thumbnail_url'] ??
            json['image_url'] ??
            json['imageUrl'] ??
            json['thumbnailUrl'] ??
            json['thumbnail_url']) as String? ??
        '';

    return CartItemModel(
      id: json['id']?.toString() ?? '',
      category: categoryVal,
      title: titleVal,
      subtitle: productMap?['description'] as String? ?? json['subtitle'] as String? ?? '',
      price: priceVal,
      quantity: (json['quantity'] as num?)?.toInt() ?? 1,
      imageUrl: imgVal,
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
