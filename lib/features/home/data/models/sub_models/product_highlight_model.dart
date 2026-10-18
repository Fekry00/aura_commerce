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
  });

  factory ProductHighlightModel.fromJson(Map<String, dynamic> json) {
    return ProductHighlightModel(
      id: json['id']?.toString() ?? '',
      title: json['title'] as String? ?? '',
      price: (json['price'] as num?)?.toDouble() ?? 0.0,
      imageUrl: (json['image_url'] ?? json['imageUrl']) as String? ?? '',
      rating: json['rating'] is Map<String, dynamic>
          ? ProductRatingModel.fromJson(json['rating'] as Map<String, dynamic>)
          : const ProductRatingModel(average: 0.0, reviewsCount: 0),
      badge: json['badge'] as String?,
      isFavorite: (json['is_favorite'] ?? json['isFavorite']) as bool? ?? false,
      isPopular: (json['is_popular'] ?? json['isPopular']) as bool? ?? false,
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
    };
  }
}
