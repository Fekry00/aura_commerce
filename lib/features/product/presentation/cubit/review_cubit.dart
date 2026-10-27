import 'package:aura/features/product/domain/entities/sub_entities/product_review_entity.dart';
import 'package:aura/features/product/domain/usecases/get_product_reviews_usecase.dart';
import 'package:aura/features/product/domain/usecases/submit_product_review_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'review_state.dart';

class ReviewCubit extends Cubit<ReviewState> {
  ReviewCubit({
    required this.getProductReviewsUseCase,
    required this.submitProductReviewUseCase,
  }) : super(const ReviewInitialState());

  final GetProductReviewsUseCase getProductReviewsUseCase;
  final SubmitProductReviewUseCase submitProductReviewUseCase;

  List<ProductReviewEntity> _cachedReviews = [];
  List<ProductReviewEntity> get reviews => _cachedReviews;

  Future<void> fetchReviews(String productId) async {
    emit(const ReviewLoadingState());

    final result = await getProductReviewsUseCase(productId: productId);

    result.fold(
      (failure) => emit(ReviewErrorState(message: failure.errMessage)),
      (items) {
        _cachedReviews = items;
        emit(ReviewSuccessState(reviews: items));
      },
    );
  }

  Future<void> submitReview({
    required String productId,
    required double rating,
    required String comment,
  }) async {
    emit(const ReviewSubmittingState());

    final result = await submitProductReviewUseCase(
      productId: productId,
      rating: rating,
      comment: comment,
    );

    result.fold(
      (failure) => emit(ReviewErrorState(message: failure.errMessage)),
      (newReview) {
        _cachedReviews = [newReview, ..._cachedReviews];
        emit(ReviewSubmitSuccessState(
          review: newReview,
          message: 'Review submitted successfully!',
        ));
        emit(ReviewSuccessState(reviews: _cachedReviews));
      },
    );
  }
}
