import 'package:aura/core/theme/app_colors.dart';
import 'package:aura/core/theme/app_typography.dart';
import 'package:aura/core/widgets/shimmer/app_shimmer.dart';
import 'package:flutter/material.dart';

/// Dedicated Shimmer Skeleton for Wishlist Screen matching item cards and summary
class WishlistShimmerSkeleton extends StatelessWidget {
  const WishlistShimmerSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.margin),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 1. Sanctuary Summary Card Skeleton
          Container(
            padding: const EdgeInsets.all(AppSpacing.margin),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(AppSpacing.spaceMd),
              border: Border.all(color: AppColors.outlineVariant.withValues(alpha: 0.6)),
            ),
            child: AppShimmer(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ShimmerBox(
                        width: 80,
                        height: 12,
                        borderRadius: AppSpacing.spaceXs,
                      ),
                      SizedBox(height: AppSpacing.spaceSm),
                      ShimmerBox(
                        width: 120,
                        height: 20,
                        borderRadius: AppSpacing.spaceSm,
                      ),
                    ],
                  ),
                  ShimmerBox(
                    width: 110,
                    height: 38,
                    borderRadius: AppSpacing.spaceSm,
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.spaceMd),

          // 2. Filter chips skeleton
          AppShimmer(
            child: Row(
              children: const [
                ShimmerBox(
                  width: 50,
                  height: 32,
                  borderRadius: AppSpacing.spaceMd,
                ),
                SizedBox(width: AppSpacing.spaceSm),
                ShimmerBox(
                  width: 80,
                  height: 32,
                  borderRadius: AppSpacing.spaceMd,
                ),
                SizedBox(width: AppSpacing.spaceSm),
                ShimmerBox(
                  width: 70,
                  height: 32,
                  borderRadius: AppSpacing.spaceMd,
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.spaceMd),

          // 3. Wishlist Items Skeletons
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: 3,
            separatorBuilder: (_, __) =>
                const SizedBox(height: AppSpacing.space12),
            itemBuilder: (context, index) {
              return Container(
                padding: const EdgeInsets.all(AppSpacing.space12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(AppSpacing.spaceMd),
                  border: Border.all(
                    color: AppColors.outlineVariant.withValues(alpha: 0.6),
                  ),
                ),
                child: AppShimmer(
                  child: Row(
                    children: [
                      // Product Image thumbnail
                      const ShimmerBox(
                        width: 90,
                        height: 90,
                        borderRadius: AppSpacing.space12,
                      ),
                      const SizedBox(width: AppSpacing.space12),
                      // Details
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const ShimmerBox(
                              width: 60,
                              height: 10,
                              borderRadius: AppSpacing.spaceXs,
                            ),
                            const SizedBox(height: AppSpacing.spaceXs),
                            const ShimmerBox(
                              width: 160,
                              height: 14,
                              borderRadius: AppSpacing.spaceXs,
                            ),
                            const SizedBox(height: AppSpacing.spaceXs),
                            const ShimmerBox(
                              width: 100,
                              height: 14,
                              borderRadius: AppSpacing.spaceXs,
                            ),
                            const SizedBox(height: AppSpacing.spaceSm),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: const [
                                ShimmerBox(
                                  width: 70,
                                  height: 16,
                                  borderRadius: AppSpacing.spaceXs,
                                ),
                                ShimmerBox(
                                  width: 84,
                                  height: 30,
                                  borderRadius: AppSpacing.spaceSm,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
