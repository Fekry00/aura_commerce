import 'package:aura/core/theme/app_typography.dart';
import 'package:aura/features/product/domain/entities/sub_entities/product_item_entity.dart';
import 'package:aura/features/product/domain/entities/sub_entities/product_review_entity.dart';
import 'package:aura/features/product/presentation/cubit/review_cubit.dart';
import 'package:aura/features/product/presentation/widgets/reviews_consensus_summary.dart';
import 'package:aura/features/product/presentation/widgets/reviews_list_section.dart';
import 'package:aura/features/product/presentation/widgets/reviews_product_header_card.dart';
import 'package:aura/features/product/presentation/widgets/reviews_shimmer_skeleton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductReviewsBody extends StatelessWidget {
  final ProductItemEntity product;
  final List<ProductReviewEntity> reviews;
  final bool isLoading;
  final VoidCallback? onWriteReviewTap;

  const ProductReviewsBody({
    super.key,
    required this.product,
    required this.reviews,
    required this.isLoading,
    this.onWriteReviewTap,
  });

  @override
  Widget build(BuildContext context) {
    if (isLoading && reviews.isEmpty) {
      return const ReviewsShimmerSkeleton();
    }

    final reviewCubit = context.watch<ReviewCubit>();
    final filteredReviews = reviewCubit.filteredReviews;
    final filterLabels = reviewCubit.filterLabels;
    final selectedFilter = reviewCubit.selectedFilter;

    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.all(AppSpacing.margin),
      child: Column(
        children: [
          ReviewsProductHeaderCard(
            product: product,
            onWriteReview: onWriteReviewTap,
          ),
          const SizedBox(height: AppSpacing.spaceMd),
          ReviewsConsensusSummary.fromReviews(reviews: reviews),
          const SizedBox(height: AppSpacing.spaceLg),
          ReviewsListSection(
            reviews: filteredReviews,
            filterLabels: filterLabels,
            selectedFilter: selectedFilter,
            onFilterSelected: (index) => reviewCubit.setFilter(index),
            onWriteReview: onWriteReviewTap,
          ),
          const SizedBox(height: AppSpacing.spaceXl),
        ],
      ),
    );
  }
}
