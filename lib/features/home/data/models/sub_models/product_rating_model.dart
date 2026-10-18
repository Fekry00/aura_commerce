import 'package:aura/features/home/domain/entities/sub_entities/product_rating_entity.dart';

class ProductRatingModel extends ProductRatingEntity {
  const ProductRatingModel({
    required super.average,
    required super.reviewsCount,
  });

  factory ProductRatingModel.fromJson(Map<String, dynamic> json) {
    return ProductRatingModel(
      average: (json['average'] as num?)?.toDouble() ?? 0.0,
      reviewsCount:
          ((json['reviews_count'] ?? json['reviewsCount']) as num?)?.toInt() ??
          0,
    );
  }

  Map<String, dynamic> toJson() {
    return {'average': average, 'reviews_count': reviewsCount};
  }
}
