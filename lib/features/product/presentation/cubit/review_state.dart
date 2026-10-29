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
  const ReviewSuccessState({
    required this.reviews,
    this.selectedFilter = 0,
  });

  final List<ProductReviewEntity> reviews;
  final int selectedFilter;

  List<ProductReviewEntity> get filteredReviews {
    if (selectedFilter == 1) {
      return reviews.where((r) => r.rating.round() == 5).toList();
    } else if (selectedFilter == 2) {
      return reviews.where((r) => r.rating.round() == 4).toList();
    }
    return reviews;
  }

  List<String> get filterLabels {
    final count = reviews.length;
    final stars5Count = reviews.where((r) => r.rating.round() == 5).length;
    final stars4Count = reviews.where((r) => r.rating.round() == 4).length;

    return [
      'All ($count)',
      '★ 5 Stars ($stars5Count)',
      '★ 4 Stars ($stars4Count)',
    ];
  }

  ReviewSuccessState copyWith({
    List<ProductReviewEntity>? reviews,
    int? selectedFilter,
  }) {
    return ReviewSuccessState(
      reviews: reviews ?? this.reviews,
      selectedFilter: selectedFilter ?? this.selectedFilter,
    );
  }
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
typedef ReviewSubmitSuccess = ReviewSubmitSuccessState;

class ReviewErrorState extends ReviewState {
  const ReviewErrorState({required this.message});

  final String message;
}
typedef ReviewError = ReviewErrorState;
