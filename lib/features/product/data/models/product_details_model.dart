import 'package:aura/features/product/domain/entities/product_details_entity.dart';
import 'sub_models/product_item_model.dart';
import 'sub_models/product_review_model.dart';

class ProductDetailsModel extends ProductDetailsEntity {
  const ProductDetailsModel({
    required ProductItemModel super.product,
    required List<ProductReviewModel> super.reviews,
  });

  factory ProductDetailsModel.fromJson(Map<String, dynamic> json) {
    final Map<String, dynamic> productMap;
    if (json['data'] is Map<String, dynamic>) {
      productMap = json['data'] as Map<String, dynamic>;
    } else if (json['product'] is Map<String, dynamic>) {
      productMap = json['product'] as Map<String, dynamic>;
    } else {
      productMap = json;
    }

    final reviewsList = (productMap['reviews'] ?? json['reviews']) as List<dynamic>? ?? [];

    return ProductDetailsModel(
      product: ProductItemModel.fromJson(productMap),
      reviews: reviewsList
          .map((e) => ProductReviewModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'product': (product as ProductItemModel).toJson(),
      'reviews':
          reviews.map((e) => (e as ProductReviewModel).toJson()).toList(),
    };
  }
}
