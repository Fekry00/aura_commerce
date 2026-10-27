import 'package:aura/core/theme/app_typography.dart';
import 'package:aura/core/widgets/shimmer/app_shimmer.dart';
import 'package:flutter/material.dart';

/// Full-page Shimmer Skeleton for Home Screen
class HomeShimmerSkeleton extends StatelessWidget {
  const HomeShimmerSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return AppShimmer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 1. Hero Banner Skeleton
          Container(
            height: 380,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(24),
            ),
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const ShimmerBox(width: 90, height: 22, borderRadius: 12),
                const SizedBox(height: 12),
                const ShimmerBox(width: 220, height: 28, borderRadius: 6),
                const SizedBox(height: 8),
                const ShimmerBox(width: 160, height: 16, borderRadius: 6),
                const SizedBox(height: 20),
                Row(
                  children: const [
                    ShimmerBox(width: 120, height: 42, borderRadius: 24),
                    SizedBox(width: 12),
                    ShimmerBox.circular(size: 42),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.spaceSm),

          // 2. Curated Drop Timer Bar
          const ShimmerBox(
            width: double.infinity,
            height: 48,
            borderRadius: 14,
          ),
          const SizedBox(height: AppSpacing.spaceLg),

          // 3. Categories Section Skeleton
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              ShimmerBox(width: 140, height: 20, borderRadius: 6),
              ShimmerBox(width: 60, height: 16, borderRadius: 6),
            ],
          ),
          const SizedBox(height: AppSpacing.spaceMd),
          SizedBox(
            height: 94,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 5,
              separatorBuilder: (_, __) => const SizedBox(width: 16),
              itemBuilder: (context, index) {
                return Column(
                  children: const [
                    ShimmerBox.circular(size: 64),
                    SizedBox(height: 8),
                    ShimmerBox(width: 50, height: 12, borderRadius: 4),
                  ],
                );
              },
            ),
          ),
          const SizedBox(height: AppSpacing.spaceLg),

          // 4. Curated Highlights Header Skeleton
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              ShimmerBox(width: 150, height: 22, borderRadius: 6),
              ShimmerBox(width: 80, height: 16, borderRadius: 6),
            ],
          ),
          const SizedBox(height: AppSpacing.spaceSm),
          Row(
            children: const [
              ShimmerBox(width: 76, height: 32, borderRadius: 16),
              SizedBox(width: 8),
              ShimmerBox(width: 90, height: 32, borderRadius: 16),
              SizedBox(width: 8),
              ShimmerBox(width: 80, height: 32, borderRadius: 16),
            ],
          ),
          const SizedBox(height: AppSpacing.spaceMd),

          // 5. Products Grid Skeleton (4 product cards)
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: 4,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.60,
              crossAxisSpacing: AppSpacing.spaceSm,
              mainAxisSpacing: AppSpacing.spaceSm,
            ),
            itemBuilder: (context, index) {
              return const ProductCardShimmer();
            },
          ),
          const SizedBox(height: AppSpacing.spaceXl),
        ],
      ),
    );
  }
}

/// Skeleton for a single ProductCard
class ProductCardShimmer extends StatelessWidget {
  const ProductCardShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.black.withValues(alpha: 0.04)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image Area
          Expanded(
            flex: 11,
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
              ),
              child: Stack(
                children: const [
                  Positioned(
                    top: 10,
                    left: 10,
                    child: ShimmerBox(width: 50, height: 18, borderRadius: 6),
                  ),
                  Positioned(
                    top: 8,
                    right: 8,
                    child: ShimmerBox.circular(size: 28),
                  ),
                ],
              ),
            ),
          ),
          // Info Area
          Expanded(
            flex: 8,
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      ShimmerBox(width: 60, height: 10, borderRadius: 4),
                      SizedBox(height: 6),
                      ShimmerBox(width: double.infinity, height: 13, borderRadius: 4),
                      SizedBox(height: 4),
                      ShimmerBox(width: 90, height: 13, borderRadius: 4),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      ShimmerBox(width: 70, height: 16, borderRadius: 4),
                      ShimmerBox.circular(size: 32),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
