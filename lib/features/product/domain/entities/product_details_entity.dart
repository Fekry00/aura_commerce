import 'sub_entities/product_item_entity.dart';
import 'sub_entities/product_review_entity.dart';

class ProductDetailsEntity {
  const ProductDetailsEntity({
    required this.product,
    required this.reviews,
  });

  final ProductItemEntity product;
  final List<ProductReviewEntity> reviews;
}
