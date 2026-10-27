import 'package:aura/features/product/domain/entities/sub_entities/product_review_entity.dart';

abstract class ReviewState {
  const ReviewState();
}

class ReviewInitialState extends ReviewState {
  const ReviewInitialState();
}

class ReviewLoadingState extends ReviewState {
  const ReviewLoadingState();
}

class ReviewSuccessState extends ReviewState {
  const ReviewSuccessState({required this.reviews});
  final List<ProductReviewEntity> reviews;
}

class ReviewSubmittingState extends ReviewState {
  const ReviewSubmittingState();
}

class ReviewSubmitSuccessState extends ReviewState {
  const ReviewSubmitSuccessState({
    required this.review,
    required this.message,
  });
  final ProductReviewEntity review;
  final String message;
}

class ReviewErrorState extends ReviewState {
  const ReviewErrorState({required this.message});
  final String message;
}
