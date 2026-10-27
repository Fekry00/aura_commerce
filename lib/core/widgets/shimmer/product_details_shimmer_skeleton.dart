import 'package:aura/core/theme/app_typography.dart';
import 'package:aura/core/widgets/shimmer/app_shimmer.dart';
import 'package:flutter/material.dart';

/// Shimmer Skeleton for Product Details Screen
class ProductDetailsShimmerSkeleton extends StatelessWidget {
  const ProductDetailsShimmerSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return AppShimmer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Hero Image Area
          const AspectRatio(
            aspectRatio: 1.0,
            child: ShimmerBox(
              width: double.infinity,
              height: double.infinity,
              borderRadius: 0,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(AppSpacing.margin),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                ShimmerBox(width: 80, height: 22, borderRadius: 8),
                SizedBox(height: 12),
                ShimmerBox(width: double.infinity, height: 24, borderRadius: 6),
                SizedBox(height: 6),
                ShimmerBox(width: 200, height: 24, borderRadius: 6),
                SizedBox(height: 12),
                Row(
                  children: [
                    ShimmerBox(width: 80, height: 16, borderRadius: 4),
                    SizedBox(width: 12),
                    ShimmerBox(width: 100, height: 16, borderRadius: 4),
                  ],
                ),
                SizedBox(height: 20),
                ShimmerBox(width: 130, height: 28, borderRadius: 6),
                SizedBox(height: 24),
                Divider(),
                SizedBox(height: 16),
                ShimmerBox(width: 100, height: 16, borderRadius: 4),
                SizedBox(height: 10),
                ShimmerBox(width: double.infinity, height: 14, borderRadius: 4),
                SizedBox(height: 6),
                ShimmerBox(width: double.infinity, height: 14, borderRadius: 4),
                SizedBox(height: 6),
                ShimmerBox(width: 180, height: 14, borderRadius: 4),
                SizedBox(height: 24),
                ShimmerBox(width: double.infinity, height: 52, borderRadius: 12),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
