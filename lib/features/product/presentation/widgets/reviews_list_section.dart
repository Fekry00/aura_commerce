import 'package:aura/core/theme/app_colors.dart';
import 'package:aura/core/theme/app_typography.dart';
import 'package:aura/features/product/domain/entities/sub_entities/product_review_entity.dart';
import 'package:aura/features/product/presentation/widgets/reviewer_avatar.dart';
import 'package:flutter/material.dart';

class ReviewsListSection extends StatelessWidget {
  final List<ProductReviewEntity> reviews;
  final List<String> filterLabels;
  final int selectedFilter;
  final ValueChanged<int>? onFilterSelected;
  final VoidCallback? onWriteReview;

  const ReviewsListSection({
    super.key,
    required this.reviews,
    required this.filterLabels,
    this.selectedFilter = 0,
    this.onFilterSelected,
    this.onWriteReview,
  });

  @override
  Widget build(BuildContext context) {
    final count = reviews.length;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Authenticated Reviews ($count)',
              style: AppTypography.bodySm.copyWith(
                fontWeight: FontWeight.w700,
                fontSize: 13,
              ),
            ),
            if (onWriteReview != null)
              GestureDetector(
                onTap: onWriteReview,
                child: Text(
                  '+ Write Review',
                  style: AppTypography.bodySm.copyWith(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF1E382B),
                  ),
                ),
              ),
          ],
        ),
        const SizedBox(height: AppSpacing.spaceSm),
        if (filterLabels.isNotEmpty) ...[
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            child: Row(
              children: List.generate(filterLabels.length, (index) {
                final isSelected = selectedFilter == index;
                return GestureDetector(
                  onTap: () => onFilterSelected?.call(index),
                  child: Container(
                    margin: const EdgeInsets.only(right: 8),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? const Color(0xFF1E382B)
                          : const Color(0xFFF1F3F5),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Text(
                      filterLabels[index],
                      style: AppTypography.labelSm.copyWith(
                        color: isSelected
                            ? Colors.white
                            : AppColors.slateHeadline,
                        fontWeight:
                            isSelected ? FontWeight.w700 : FontWeight.w500,
                        fontSize: 11,
                      ),
                    ),
                  ),
                );
              }),
            ),
          ),
          const SizedBox(height: AppSpacing.spaceMd),
        ],
        if (reviews.isEmpty) ...[
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 36, horizontal: 20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: const Color(0xFFE9ECEF)),
            ),
            child: Column(
              children: [
                const Icon(
                  Icons.reviews_outlined,
                  size: 40,
                  color: AppColors.slateBody,
                ),
                const SizedBox(height: 12),
                Text(
                  'No reviews yet',
                  style: AppTypography.bodySm.copyWith(
                    fontWeight: FontWeight.w700,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Be the first to share your experience with this item.',
                  style: AppTypography.bodySm.copyWith(
                    color: AppColors.slateBody,
                    fontSize: 12,
                  ),
                  textAlign: TextAlign.center,
                ),
                if (onWriteReview != null) ...[
                  const SizedBox(height: 16),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF1E382B),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    onPressed: onWriteReview,
                    child: const Text('Add Review'),
                  ),
                ],
              ],
            ),
          ),
        ] else ...[
          ...reviews.map(
            (review) => Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: _ReviewCard(review: review),
            ),
          ),
        ],
      ],
    );
  }
}

class _ReviewCard extends StatelessWidget {
  final ProductReviewEntity review;

  const _ReviewCard({required this.review});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.spaceMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE9ECEF)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ReviewerAvatar(review: review, radius: 16),
              const SizedBox(width: AppSpacing.spaceSm),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      review.authorName,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: AppTypography.bodySm.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ...List.generate(
                          review.rating.clamp(1, 5).toInt(),
                          (_) => const Icon(
                            Icons.star_rounded,
                            color: Colors.amber,
                            size: 14,
                          ),
                        ),
                        const SizedBox(width: 6),
                        Flexible(
                          child: Text(
                            review.purchaseInfo,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: AppTypography.bodySm.copyWith(
                              color: AppColors.slateBody,
                              fontSize: 10,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: const Color(0xFFE8F5E9),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.verified_outlined,
                      color: Color(0xFF2E7D32),
                      size: 12,
                    ),
                    const SizedBox(width: 3),
                    Text(
                      review.authorStatus,
                      style: AppTypography.labelCaps.copyWith(
                        color: const Color(0xFF2E7D32),
                        fontSize: 8.5,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.spaceSm),
          Text(
            review.comment,
            style: AppTypography.bodySm.copyWith(fontSize: 12, height: 1.4),
          ),
        ],
      ),
    );
  }
}