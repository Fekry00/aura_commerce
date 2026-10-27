import 'package:aura/core/network/api/end_points.dart';
import 'package:aura/features/home/domain/entities/sub_entities/product_highlight_entity.dart';

import 'product_rating_model.dart';

class ProductHighlightModel extends ProductHighlightEntity {
  const ProductHighlightModel({
    required super.id,
    required super.title,
    required super.price,
    required super.imageUrl,
    required ProductRatingModel super.rating,
    super.badge,
    super.isFavorite,
    super.isPopular,
    super.categoryId,
    super.categoryName,
  });

  factory ProductHighlightModel.fromJson(Map<String, dynamic> json) {
    final nameVal = (json['name'] ?? json['title']) as String? ?? '';
    final priceVal = (json['minPrice'] ?? json['min_price'] ?? json['price']) as num? ?? 0;
    final img = EndPoint.fixImageUrl((json['thumbnailUrl'] ??
        json['thumbnail_url'] ??
        json['image_url'] ??
        json['imageUrl'] ??
        json['image']) as String?);
    final isFeat = json['isFeatured'] as bool? ?? (json['is_featured'] as bool? ?? false);
    final isBest = json['isBestSeller'] as bool? ?? (json['is_best_seller'] as bool? ?? false);
    final discount = (json['discountPercent'] ?? json['discount_percent']) as num? ?? 0;
    final badgeVal = json['badge'] as String? ??
        (isFeat ? 'FEATURED' : (isBest ? 'BESTSELLER' : (discount > 0 ? '$discount% OFF' : null)));

    final categoryMap = json['category'] is Map<String, dynamic>
        ? json['category'] as Map<String, dynamic>
        : null;
    final catId = categoryMap != null
        ? (categoryMap['id'] is int
            ? categoryMap['id'] as int
            : int.tryParse(categoryMap['id']?.toString() ?? ''))
        : (json['category_id'] is int
            ? json['category_id'] as int
            : int.tryParse(json['category_id']?.toString() ?? ''));
    final catName = categoryMap?['name'] as String? ??
        (json['category'] is String ? json['category'] as String : null);

    return ProductHighlightModel(
      id: json['id']?.toString() ?? '',
      title: nameVal,
      price: priceVal.toDouble(),
      imageUrl: img,
      rating: json['rating'] is Map<String, dynamic>
          ? ProductRatingModel.fromJson(json['rating'] as Map<String, dynamic>)
          : const ProductRatingModel(average: 4.9, reviewsCount: 120),
      badge: badgeVal,
      isFavorite: (json['is_favorite'] ?? json['isFavorite']) as bool? ?? false,
      isPopular: isFeat || isBest || discount > 0 || (json['is_popular'] as bool? ?? false),
      categoryId: catId,
      categoryName: catName,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'price': price,
      'image_url': imageUrl,
      'rating': (rating as ProductRatingModel).toJson(),
      'badge': badge,
      'is_favorite': isFavorite,
      'is_popular': isPopular,
      'category_id': categoryId,
      'category_name': categoryName,
    };
  }
}
