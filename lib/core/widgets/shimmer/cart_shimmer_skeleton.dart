import 'package:aura/core/theme/app_typography.dart';
import 'package:aura/core/widgets/shimmer/app_shimmer.dart';
import 'package:flutter/material.dart';

/// Shimmer Skeleton for Cart Screen
class CartShimmerSkeleton extends StatelessWidget {
  const CartShimmerSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return AppShimmer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 1. Shipping Meter Card Skeleton
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: Colors.black.withValues(alpha: 0.04)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                ShimmerBox(width: 180, height: 14, borderRadius: 4),
                SizedBox(height: 10),
                ShimmerBox(width: double.infinity, height: 6, borderRadius: 3),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.spaceMd),

          // 2. Cart Items List Skeletons
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: 2,
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
                    const ShimmerBox(
                      width: 80,
                      height: 80,
                      borderRadius: 12,
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: const [
                              ShimmerBox(width: 140, height: 14, borderRadius: 4),
                              ShimmerBox.circular(size: 20),
                            ],
                          ),
                          const SizedBox(height: 6),
                          const ShimmerBox(width: 80, height: 12, borderRadius: 4),
                          const SizedBox(height: 12),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: const [
                              ShimmerBox(width: 70, height: 16, borderRadius: 4),
                              ShimmerBox(width: 86, height: 28, borderRadius: 8),
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
          const SizedBox(height: AppSpacing.spaceLg),

          // 3. Voucher Promo Card Skeleton
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.black.withValues(alpha: 0.04)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                ShimmerBox(width: 120, height: 14, borderRadius: 4),
                ShimmerBox(width: 60, height: 28, borderRadius: 6),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.spaceMd),

          // 4. Order Summary Card Skeleton
          Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: Colors.black.withValues(alpha: 0.04)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                ShimmerBox(width: 110, height: 16, borderRadius: 4),
                SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ShimmerBox(width: 60, height: 12, borderRadius: 4),
                    ShimmerBox(width: 70, height: 12, borderRadius: 4),
                  ],
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ShimmerBox(width: 50, height: 12, borderRadius: 4),
                    ShimmerBox(width: 60, height: 12, borderRadius: 4),
                  ],
                ),
                SizedBox(height: 14),
                Divider(),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ShimmerBox(width: 50, height: 16, borderRadius: 4),
                    ShimmerBox(width: 90, height: 18, borderRadius: 4),
                  ],
                ),
                SizedBox(height: 18),
                ShimmerBox(width: double.infinity, height: 50, borderRadius: 14),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.spaceXl),
        ],
      ),
    );
  }
}
