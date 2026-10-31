import 'package:aura/core/theme/app_colors.dart';
import 'package:aura/core/theme/app_typography.dart';
import 'package:aura/core/widgets/shimmer/app_shimmer.dart';
import 'package:flutter/material.dart';

/// Shimmer Skeleton for Orders List screen mirroring OrderCard layout
class OrdersShimmerSkeleton extends StatelessWidget {
  final int itemCount;

  const OrdersShimmerSkeleton({
    super.key,
    this.itemCount = 3,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.gutter,
        vertical: AppSpacing.space12,
      ),
      physics: const NeverScrollableScrollPhysics(),
      itemCount: itemCount,
      separatorBuilder: (_, __) =>
          const SizedBox(height: AppSpacing.space12),
      itemBuilder: (context, index) {
        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(AppSpacing.spaceMd),
            border: Border.all(color: AppColors.outlineVariant.withValues(alpha: 0.6)),
          ),
          padding: const EdgeInsets.all(AppSpacing.gutter),
          child: AppShimmer(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Top Row: Order ID & Status Badge
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    ShimmerBox(
                      width: 130,
                      height: 16,
                      borderRadius: AppSpacing.spaceXs,
                    ),
                    ShimmerBox(
                      width: 76,
                      height: 22,
                      borderRadius: AppSpacing.space12,
                    ),
                  ],
                ),
                const SizedBox(height: AppSpacing.spaceSm),

                // Date & Items count
                Row(
                  children: const [
                    ShimmerBox(
                      width: 90,
                      height: 12,
                      borderRadius: AppSpacing.spaceXs,
                    ),
                    SizedBox(width: AppSpacing.space12),
                    ShimmerBox(
                      width: 60,
                      height: 12,
                      borderRadius: AppSpacing.spaceXs,
                    ),
                  ],
                ),
                const SizedBox(height: AppSpacing.space12),

                // Thumbnails row
                Row(
                  children: const [
                    ShimmerBox(
                      width: AppSpacing.space2Xl,
                      height: AppSpacing.space2Xl,
                      borderRadius: AppSpacing.spaceSm,
                    ),
                    SizedBox(width: AppSpacing.spaceSm),
                    ShimmerBox(
                      width: AppSpacing.space2Xl,
                      height: AppSpacing.space2Xl,
                      borderRadius: AppSpacing.spaceSm,
                    ),
                    SizedBox(width: AppSpacing.spaceSm),
                    ShimmerBox(
                      width: AppSpacing.space2Xl,
                      height: AppSpacing.space2Xl,
                      borderRadius: AppSpacing.spaceSm,
                    ),
                  ],
                ),
                const SizedBox(height: AppSpacing.space12),

                // Divider
                const Divider(height: 1),
                const SizedBox(height: AppSpacing.spaceSm),

                // Bottom Row: Total & Action button
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ShimmerBox(
                          width: 40,
                          height: 10,
                          borderRadius: AppSpacing.space2Xs,
                        ),
                        SizedBox(height: AppSpacing.spaceXs),
                        ShimmerBox(
                          width: 90,
                          height: 18,
                          borderRadius: AppSpacing.spaceXs,
                        ),
                      ],
                    ),
                    ShimmerBox(
                      width: 80,
                      height: 32,
                      borderRadius: AppSpacing.spaceSm,
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
