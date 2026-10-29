import 'package:aura/core/theme/app_colors.dart';
import 'package:aura/core/theme/app_typography.dart';
import 'package:aura/core/widgets/shimmer/app_shimmer.dart';
import 'package:flutter/material.dart';

/// Shimmer Skeleton for Profile screen mirroring avatar, user tier, stats, quick actions, and settings tiles
class ProfileShimmerSkeleton extends StatelessWidget {
  const ProfileShimmerSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return AppShimmer(
      child: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.gutter,
          vertical: AppSpacing.space12,
        ),
        child: Column(
          children: [
            // 1. Profile Tier Card Skeleton
            Container(
              padding: const EdgeInsets.all(AppSpacing.margin),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(AppSpacing.margin),
                border: Border.all(
                  color: AppColors.outlineVariant.withValues(alpha: 0.6),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const ShimmerBox.circular(size: 64),
                      const SizedBox(width: AppSpacing.spaceMd),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            ShimmerBox(
                              width: 140,
                              height: 18,
                              borderRadius: AppSpacing.spaceXs,
                            ),
                            SizedBox(height: AppSpacing.spaceSm),
                            ShimmerBox(
                              width: 100,
                              height: 12,
                              borderRadius: AppSpacing.spaceXs,
                            ),
                            SizedBox(height: AppSpacing.spaceXs),
                            ShimmerBox(
                              width: 80,
                              height: 12,
                              borderRadius: AppSpacing.spaceXs,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.spaceMd),

                  // Stats row skeleton
                  Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: AppSpacing.spaceMd,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.surfaceContainerLow,
                      borderRadius: BorderRadius.circular(AppSpacing.spaceMd),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: List.generate(
                        3,
                        (index) => Column(
                          children: const [
                            ShimmerBox(
                              width: 32,
                              height: 18,
                              borderRadius: AppSpacing.spaceXs,
                            ),
                            SizedBox(height: AppSpacing.spaceXs),
                            ShimmerBox(
                              width: 54,
                              height: 10,
                              borderRadius: AppSpacing.space2Xs,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: AppSpacing.spaceMd),

            // 2. Quick Actions 2x2 Grid Skeleton
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 4,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 1.25,
                crossAxisSpacing: AppSpacing.space12,
                mainAxisSpacing: AppSpacing.space12,
              ),
              itemBuilder: (context, index) {
                return Container(
                  padding: const EdgeInsets.all(AppSpacing.space12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(AppSpacing.margin),
                    border: Border.all(
                      color: AppColors.outlineVariant.withValues(alpha: 0.6),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          ShimmerBox(
                            width: 36,
                            height: 36,
                            borderRadius: AppSpacing.spaceSm,
                          ),
                          ShimmerBox(
                            width: 48,
                            height: 18,
                            borderRadius: AppSpacing.spaceXs,
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          ShimmerBox(
                            width: 80,
                            height: 14,
                            borderRadius: AppSpacing.spaceXs,
                          ),
                          SizedBox(height: AppSpacing.space2Xs),
                          ShimmerBox(
                            width: 50,
                            height: 10,
                            borderRadius: AppSpacing.space2Xs,
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
            const SizedBox(height: AppSpacing.spaceMd),

            // 3. Settings Sections List Tiles Skeleton
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(AppSpacing.margin),
                border: Border.all(
                  color: AppColors.outlineVariant.withValues(alpha: 0.6),
                ),
              ),
              child: Column(
                children: List.generate(
                  4,
                  (index) => Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.margin,
                      vertical: AppSpacing.space12,
                    ),
                    child: Row(
                      children: const [
                        ShimmerBox.circular(size: 24),
                        SizedBox(width: AppSpacing.space12),
                        Expanded(
                          child: ShimmerBox(
                            width: 140,
                            height: 14,
                            borderRadius: AppSpacing.spaceXs,
                          ),
                        ),
                        ShimmerBox(
                          width: 16,
                          height: 16,
                          borderRadius: AppSpacing.spaceXs,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: AppSpacing.spaceXl),
          ],
        ),
      ),
    );
  }
}
