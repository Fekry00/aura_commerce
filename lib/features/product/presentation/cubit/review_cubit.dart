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

  int _selectedFilter = 0;
  int get selectedFilter => _selectedFilter;

  @override
  void emit(ReviewState state) {
    if (!isClosed) {
      super.emit(state);
    }
  }

  void setFilter(int index) {
    if (_selectedFilter == index) return;
    _selectedFilter = index;
    if (state is ReviewSuccessState) {
      emit((state as ReviewSuccessState).copyWith(selectedFilter: index));
    }
  }

  List<ProductReviewEntity> get filteredReviews {
    if (_selectedFilter == 1) {
      return _cachedReviews.where((r) => r.rating.round() == 5).toList();
    } else if (_selectedFilter == 2) {
      return _cachedReviews.where((r) => r.rating.round() == 4).toList();
    }
    return _cachedReviews;
  }

  List<String> get filterLabels {
    final count = _cachedReviews.length;
    final stars5Count =
        _cachedReviews.where((r) => r.rating.round() == 5).length;
    final stars4Count =
        _cachedReviews.where((r) => r.rating.round() == 4).length;

    return [
      'All ($count)',
      '★ 5 Stars ($stars5Count)',
      '★ 4 Stars ($stars4Count)',
    ];
  }

  Future<void> fetchReviews(String productId) async {
    emit(const ReviewLoadingState());

    final result = await getProductReviewsUseCase(productId: productId);

    result.fold(
      (failure) => emit(ReviewErrorState(message: failure.errMessage)),
      (items) {
        _cachedReviews = items;
        emit(ReviewSuccessState(
          reviews: items,
          selectedFilter: _selectedFilter,
        ));
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
        emit(ReviewSuccessState(
          reviews: _cachedReviews,
          selectedFilter: _selectedFilter,
        ));
      },
    );
  }
}
