import 'package:aura/core/theme/app_typography.dart';
import 'package:aura/core/widgets/shimmer/app_shimmer.dart';
import 'package:flutter/material.dart';

/// Dedicated Shimmer Skeleton for Cart Screen matching Cart Item Cards and Order Summary
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
            padding: const EdgeInsets.all(AppSpacing.gutter),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(AppSpacing.spaceMd),
              border: Border.all(color: Colors.black.withValues(alpha: 0.04)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                ShimmerBox(
                  width: 180,
                  height: 14,
                  borderRadius: AppSpacing.spaceXs,
                ),
                SizedBox(height: AppSpacing.spaceSm),
                ShimmerBox(
                  width: double.infinity,
                  height: 6,
                  borderRadius: 3,
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.spaceMd),

          // 2. Cart Items List Skeletons
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
                    color: Colors.black.withValues(alpha: 0.04),
                  ),
                ),
                child: Row(
                  children: [
                    const ShimmerBox(
                      width: 80,
                      height: 80,
                      borderRadius: AppSpacing.space12,
                    ),
                    const SizedBox(width: AppSpacing.space12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: const [
                              ShimmerBox(
                                width: 140,
                                height: 14,
                                borderRadius: AppSpacing.spaceXs,
                              ),
                              ShimmerBox.circular(size: AppSpacing.margin),
                            ],
                          ),
                          const SizedBox(height: AppSpacing.spaceXs),
                          const ShimmerBox(
                            width: 80,
                            height: 12,
                            borderRadius: AppSpacing.spaceXs,
                          ),
                          const SizedBox(height: AppSpacing.space12),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: const [
                              ShimmerBox(
                                width: 70,
                                height: 16,
                                borderRadius: AppSpacing.spaceXs,
                              ),
                              ShimmerBox(
                                width: 86,
                                height: 28,
                                borderRadius: AppSpacing.spaceSm,
                              ),
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
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.gutter,
              vertical: AppSpacing.space12,
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(AppSpacing.space12),
              border: Border.all(color: Colors.black.withValues(alpha: 0.04)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                ShimmerBox(
                  width: 120,
                  height: 14,
                  borderRadius: AppSpacing.spaceXs,
                ),
                ShimmerBox(
                  width: 60,
                  height: 28,
                  borderRadius: AppSpacing.spaceXs,
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.spaceMd),

          // 4. Order Summary Card Skeleton
          Container(
            padding: const EdgeInsets.all(AppSpacing.margin),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(AppSpacing.spaceMd),
              border: Border.all(color: Colors.black.withValues(alpha: 0.04)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                ShimmerBox(
                  width: 110,
                  height: 16,
                  borderRadius: AppSpacing.spaceXs,
                ),
                SizedBox(height: AppSpacing.gutter),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ShimmerBox(
                      width: 60,
                      height: 12,
                      borderRadius: AppSpacing.spaceXs,
                    ),
                    ShimmerBox(
                      width: 70,
                      height: 12,
                      borderRadius: AppSpacing.spaceXs,
                    ),
                  ],
                ),
                SizedBox(height: AppSpacing.spaceSm),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ShimmerBox(
                      width: 50,
                      height: 12,
                      borderRadius: AppSpacing.spaceXs,
                    ),
                    ShimmerBox(
                      width: 60,
                      height: 12,
                      borderRadius: AppSpacing.spaceXs,
                    ),
                  ],
                ),
                SizedBox(height: AppSpacing.space12),
                Divider(),
                SizedBox(height: AppSpacing.spaceSm),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ShimmerBox(
                      width: 50,
                      height: 16,
                      borderRadius: AppSpacing.spaceXs,
                    ),
                    ShimmerBox(
                      width: 90,
                      height: 18,
                      borderRadius: AppSpacing.spaceXs,
                    ),
                  ],
                ),
                SizedBox(height: AppSpacing.gutter),
                ShimmerBox(
                  width: double.infinity,
                  height: AppSpacing.space2Xl,
                  borderRadius: AppSpacing.space12,
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.spaceXl),
        ],
      ),
    );
  }
}
