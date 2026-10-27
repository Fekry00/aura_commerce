import 'package:aura/core/widgets/shimmer/app_shimmer.dart';
import 'package:flutter/material.dart';

/// Shimmer Skeleton for Orders Screen
class OrdersShimmerSkeleton extends StatelessWidget {
  const OrdersShimmerSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return AppShimmer(
      child: ListView.separated(
        padding: const EdgeInsets.all(16),
        physics: const NeverScrollableScrollPhysics(),
        itemCount: 3,
        separatorBuilder: (_, __) => const SizedBox(height: 14),
        itemBuilder: (context, index) {
          return Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: Colors.black.withValues(alpha: 0.04)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Top header: Order ID & Status chip
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ShimmerBox(width: 120, height: 16, borderRadius: 4),
                        SizedBox(height: 6),
                        ShimmerBox(width: 80, height: 11, borderRadius: 4),
                      ],
                    ),
                    ShimmerBox(width: 75, height: 26, borderRadius: 13),
                  ],
                ),
                const SizedBox(height: 16),
                const Divider(height: 1),
                const SizedBox(height: 14),

                // Thumbnails row
                Row(
                  children: const [
                    ShimmerBox(width: 52, height: 52, borderRadius: 10),
                    SizedBox(width: 10),
                    ShimmerBox(width: 52, height: 52, borderRadius: 10),
                    SizedBox(width: 10),
                    ShimmerBox(width: 52, height: 52, borderRadius: 10),
                    Spacer(),
                    ShimmerBox(width: 40, height: 14, borderRadius: 4),
                  ],
                ),
                const SizedBox(height: 14),
                const Divider(height: 1),
                const SizedBox(height: 14),

                // Footer: Total & Actions
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ShimmerBox(width: 60, height: 11, borderRadius: 4),
                        SizedBox(height: 4),
                        ShimmerBox(width: 90, height: 16, borderRadius: 4),
                      ],
                    ),
                    Row(
                      children: [
                        ShimmerBox(width: 96, height: 34, borderRadius: 8),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
