import 'package:aura/core/theme/app_typography.dart';
import 'package:aura/core/widgets/shimmer/app_shimmer.dart';
import 'package:flutter/material.dart';

/// Shimmer Skeleton for Wishlist Screen
class WishlistShimmerSkeleton extends StatelessWidget {
  const WishlistShimmerSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return AppShimmer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 1. Sanctuary Summary Card Skeleton
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: Colors.black.withValues(alpha: 0.04)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ShimmerBox(width: 80, height: 12, borderRadius: 4),
                    SizedBox(height: 6),
                    ShimmerBox(width: 120, height: 20, borderRadius: 6),
                  ],
                ),
                ShimmerBox(width: 110, height: 38, borderRadius: 10),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.spaceMd),

          // 2. Filter chips skeleton
          Row(
            children: const [
              ShimmerBox(width: 50, height: 32, borderRadius: 16),
              SizedBox(width: 8),
              ShimmerBox(width: 80, height: 32, borderRadius: 16),
              SizedBox(width: 8),
              ShimmerBox(width: 70, height: 32, borderRadius: 16),
            ],
          ),
          const SizedBox(height: AppSpacing.spaceMd),

          // 3. Wishlist Items Skeletons
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: 3,
            separatorBuilder: (_, __) => const SizedBox(height: 12),
            itemBuilder: (context, index) {
              return Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Colors.black.withValues(alpha: 0.04)),
                ),
                child: Row(
                  children: [
                    // Product Image thumbnail
                    const ShimmerBox(
                      width: 90,
                      height: 90,
                      borderRadius: 12,
                    ),
                    const SizedBox(width: 14),
                    // Details
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const ShimmerBox(width: 60, height: 10, borderRadius: 4),
                          const SizedBox(height: 6),
                          const ShimmerBox(width: 160, height: 14, borderRadius: 4),
                          const SizedBox(height: 4),
                          const ShimmerBox(width: 100, height: 14, borderRadius: 4),
                          const SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: const [
                              ShimmerBox(width: 70, height: 16, borderRadius: 4),
                              ShimmerBox(width: 84, height: 30, borderRadius: 8),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
