import 'package:aura/core/errors/failure.dart';
import 'package:aura/features/product/domain/entities/sub_entities/product_review_entity.dart';
import 'package:aura/features/product/domain/repositories/product_repository.dart';
import 'package:dartz/dartz.dart';

class GetProductReviewsUseCase {
  const GetProductReviewsUseCase(this.repository);

  final ProductRepository repository;

  Future<Either<Failure, List<ProductReviewEntity>>> call({
    required String productId,
  }) {
    return repository.getProductReviews(productId: productId);
  }
}
