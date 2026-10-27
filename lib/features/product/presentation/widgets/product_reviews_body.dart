import 'package:aura/core/theme/app_typography.dart';
import 'package:aura/features/product/domain/entities/sub_entities/product_item_entity.dart';
import 'package:aura/features/product/domain/entities/sub_entities/product_review_entity.dart';
import 'package:aura/features/product/presentation/controllers/product_reviews_controller.dart';
import 'package:aura/features/product/presentation/widgets/reviews_consensus_summary.dart';
import 'package:aura/features/product/presentation/widgets/reviews_list_section.dart';
import 'package:aura/features/product/presentation/widgets/reviews_product_header_card.dart';
import 'package:aura/features/product/presentation/widgets/reviews_shimmer_skeleton.dart';
import 'package:flutter/material.dart';

class ProductReviewsBody extends StatelessWidget {
  final ProductItemEntity product;
  final List<ProductReviewEntity> reviews;
  final bool isLoading;
  final ProductReviewsController controller;
  final VoidCallback onStateUpdate;

  const ProductReviewsBody({
    super.key,
    required this.product,
    required this.reviews,
    required this.isLoading,
    required this.controller,
    required this.onStateUpdate,
  });

  @override
  Widget build(BuildContext context) {
    if (isLoading && reviews.isEmpty) {
      return const ReviewsShimmerSkeleton();
    }

    final filteredReviews = controller.getFilteredReviews(reviews);
    final filterLabels = controller.getFilterLabels(reviews);

    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.all(AppSpacing.margin),
      child: Column(
        children: [
          ReviewsProductHeaderCard(
            product: product,
            onWriteReview: () => controller.showAddReviewModal(
              context,
              product.id.toString(),
            ),
          ),
          const SizedBox(height: AppSpacing.spaceMd),
          ReviewsConsensusSummary.fromReviews(reviews: reviews),
          const SizedBox(height: AppSpacing.spaceLg),
          ReviewsListSection(
            reviews: filteredReviews,
            filterLabels: filterLabels,
            selectedFilter: controller.selectedFilter,
            onFilterSelected: (index) =>
                controller.onFilterSelected(index, onStateUpdate),
            onWriteReview: () => controller.showAddReviewModal(
              context,
              product.id.toString(),
            ),
          ),
          const SizedBox(height: AppSpacing.spaceXl),
        ],
      ),
    );
  }
}
