import 'package:aura/core/errors/failure.dart';
import 'package:aura/features/product/domain/entities/sub_entities/product_review_entity.dart';
import 'package:aura/features/product/domain/repositories/product_repository.dart';
import 'package:dartz/dartz.dart';

class SubmitProductReviewUseCase {
  const SubmitProductReviewUseCase(this.repository);

  final ProductRepository repository;

  Future<Either<Failure, ProductReviewEntity>> call({
    required String productId,
    required double rating,
    required String comment,
  }) {
    return repository.submitProductReview(
      productId: productId,
      rating: rating,
      comment: comment,
    );
  }
}
