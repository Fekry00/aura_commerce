import 'package:aura/features/wishlist/domain/entities/sub_entities/wishlist_item_entity.dart';

class WishlistItemModel extends WishlistItemEntity {
  const WishlistItemModel({
    required super.id,
    required super.title,
    required super.category,
    required super.price,
    super.originalPrice,
    required super.imageUrl,
    super.badge,
    required super.stockStatus,
    super.isLowStock = false,
    super.hasComplimentary = false,
  });

  factory WishlistItemModel.fromJson(Map<String, dynamic> json) {
    return WishlistItemModel(
      id: json['id']?.toString() ?? '',
      title: json['title'] as String? ?? '',
      category: json['category'] as String? ?? '',
      price: (json['price'] as num?)?.toDouble() ?? 0.0,
      originalPrice: (json['original_price'] ?? json['originalPrice']) != null
          ? ((json['original_price'] ?? json['originalPrice']) as num)
              .toDouble()
          : null,
      imageUrl: (json['image_url'] ?? json['imageUrl']) as String? ?? '',
      badge: json['badge'] as String?,
      stockStatus: (json['stock_status'] ?? json['stockStatus']) as String? ??
          'In Stock',
      isLowStock:
          (json['is_low_stock'] ?? json['isLowStock']) as bool? ?? false,
      hasComplimentary: (json['has_complimentary'] ?? json['hasComplimentary'])
              as bool? ??
          false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'category': category,
      'price': price,
      'original_price': originalPrice,
      'image_url': imageUrl,
      'badge': badge,
      'stock_status': stockStatus,
      'is_low_stock': isLowStock,
      'has_complimentary': hasComplimentary,
    };
  }
}
