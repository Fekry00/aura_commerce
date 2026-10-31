import 'package:aura/core/theme/app_colors.dart';
import 'package:aura/core/theme/app_typography.dart';
import 'package:aura/core/widgets/shimmer/app_shimmer.dart';
import 'package:flutter/material.dart';

/// Shimmer skeleton for Categories screen and Category Products grid
class CategoryShimmerSkeleton extends StatelessWidget {
  final int itemCount;

  const CategoryShimmerSkeleton({
    super.key,
    this.itemCount = 6,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.gutter,
        vertical: AppSpacing.space12,
      ),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.85,
        crossAxisSpacing: AppSpacing.gutter,
        mainAxisSpacing: AppSpacing.gutter,
      ),
      itemCount: itemCount,
      itemBuilder: (context, index) {
        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppSpacing.spaceMd),
            color: Colors.white,
            border: Border.all(
              color: AppColors.outlineVariant.withValues(alpha: 0.6),
            ),
          ),
          child: AppShimmer(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 6,
                  child: ShimmerBox(
                    width: double.infinity,
                    height: double.infinity,
                    borderRadius: AppSpacing.spaceMd,
                  ),
                ),
                Expanded(
                  flex: 4,
                  child: Padding(
                    padding: const EdgeInsets.all(AppSpacing.space12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        ShimmerBox(
                          height: 14,
                          width: 100,
                          borderRadius: AppSpacing.spaceXs,
                        ),
                        SizedBox(height: AppSpacing.spaceSm),
                        ShimmerBox(
                          height: 10,
                          width: 60,
                          borderRadius: AppSpacing.spaceXs,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

/// Shimmer for Category Details product grid
class CategoryProductsGridShimmer extends StatelessWidget {
  final int itemCount;

  const CategoryProductsGridShimmer({
    super.key,
    this.itemCount = 4,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: itemCount,
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.margin,
        vertical: AppSpacing.space12,
      ),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.60,
        crossAxisSpacing: AppSpacing.gutter,
        mainAxisSpacing: AppSpacing.gutter,
      ),
      itemBuilder: (context, index) {
        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(AppSpacing.spaceMd),
            border: Border.all(
              color: AppColors.outlineVariant.withValues(alpha: 0.4),
            ),
          ),
          child: AppShimmer(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 6,
                  child: ShimmerBox(
                    width: double.infinity,
                    height: double.infinity,
                    borderRadius: AppSpacing.spaceMd,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(AppSpacing.space12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      ShimmerBox(
                        width: 60,
                        height: 10,
                        borderRadius: AppSpacing.spaceXs,
                      ),
                      SizedBox(height: AppSpacing.spaceXs),
                      ShimmerBox(
                        width: double.infinity,
                        height: 14,
                        borderRadius: AppSpacing.spaceXs,
                      ),
                      SizedBox(height: AppSpacing.spaceSm),
                      ShimmerBox(
                        width: 80,
                        height: 16,
                        borderRadius: AppSpacing.spaceXs,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
