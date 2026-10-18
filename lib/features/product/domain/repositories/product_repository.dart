import 'package:aura/core/errors/failure.dart';
import 'package:aura/features/product/domain/entities/product_details_entity.dart';
import 'package:aura/features/product/domain/entities/sub_entities/product_review_entity.dart';
import 'package:dartz/dartz.dart';

abstract class ProductRepository {
  Future<Either<Failure, ProductDetailsEntity>> getProductDetails({
    required String productId,
  });

  Future<Either<Failure, List<ProductReviewEntity>>> getProductReviews({
    required String productId,
  });

  Future<Either<Failure, bool>> toggleFavorite({
    required String productId,
  });
}
