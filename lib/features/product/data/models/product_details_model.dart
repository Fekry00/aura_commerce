import 'package:aura/features/product/domain/entities/product_details_entity.dart';

import 'sub_models/product_item_model.dart';
import 'sub_models/product_review_model.dart';

class ProductDetailsModel extends ProductDetailsEntity {
  const ProductDetailsModel({
    required ProductItemModel super.product,
    required List<ProductReviewModel> super.reviews,
  });

  factory ProductDetailsModel.fromJson(Map<String, dynamic> json) {
    return ProductDetailsModel(
      product: json['product'] is Map<String, dynamic>
          ? ProductItemModel.fromJson(json['product'] as Map<String, dynamic>)
          : ProductItemModel.fromJson(json),
      reviews: (json['reviews'] as List<dynamic>? ?? [])
          .map((e) => ProductReviewModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'product': (product as ProductItemModel).toJson(),
      'reviews': reviews.map((e) => (e as ProductReviewModel).toJson()).toList(),
    };
  }
}
