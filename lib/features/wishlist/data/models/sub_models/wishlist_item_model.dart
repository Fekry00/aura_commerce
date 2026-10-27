import 'package:aura/core/network/api/end_points.dart';
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
    final titleVal = (json['name'] ?? json['title']) as String? ?? '';
    final catRaw = json['category'] is Map<String, dynamic>
        ? (json['category']['name'] as String? ?? '')
        : (json['category'] as String? ?? '');
    final categoryVal = catRaw.isNotEmpty
        ? catRaw
        : (json['category_name'] as String? ?? 'Curated Item');
    final priceVal = ((json['minPrice'] ?? json['min_price'] ?? json['price'] ?? json['unitPrice']) as num?)?.toDouble() ?? 0.0;
    final origPriceVal = ((json['compareAtPrice'] ?? json['compare_at_price'] ?? json['originalPrice'] ?? json['original_price']) as num?)?.toDouble();
    final imgVal = EndPoint.fixImageUrl((json['thumbnailUrl'] ??
        json['thumbnail_url'] ??
        json['imageUrl'] ??
        json['image_url'] ??
        json['image']) as String?);
    final stockNum = (json['stock'] as num?)?.toInt();
    final inStockVal = stockNum != null
        ? stockNum > 0
        : (json['inStock'] as bool? ?? (json['in_stock'] as bool? ?? true));
    final discount = (json['discountPercent'] ?? json['discount_percent']) as num? ?? 0;
    final badgeVal = json['badge'] as String? ?? (discount > 0 ? '${discount.toStringAsFixed(0)}% OFF' : null);

    return WishlistItemModel(
      id: json['id']?.toString() ?? '',
      title: titleVal,
      category: categoryVal,
      price: priceVal,
      originalPrice: origPriceVal,
      imageUrl: imgVal,
      badge: badgeVal,
      stockStatus: (json['stock_status'] ?? json['stockStatus']) as String? ??
          (stockNum != null
              ? (stockNum > 0 ? 'In Stock ($stockNum units available)' : 'Out of Stock')
              : (inStockVal ? 'In Stock' : 'Out of Stock')),
      isLowStock:
          (json['is_low_stock'] ?? json['isLowStock']) as bool? ??
          (stockNum != null && stockNum > 0 && stockNum <= 5),
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
