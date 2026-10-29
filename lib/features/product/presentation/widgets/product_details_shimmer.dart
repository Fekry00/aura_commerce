import 'package:aura/core/theme/app_typography.dart';
import 'package:aura/core/widgets/shimmer/app_shimmer.dart';
import 'package:flutter/material.dart';

/// Shimmer skeleton for Product Details screen matching hero image, variants, and specifications
class ProductDetailsShimmer extends StatelessWidget {
  const ProductDetailsShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return AppShimmer(
      child: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 1. Hero Image Area (1.05 Aspect Ratio matching ProductImageSection)
            const AspectRatio(
              aspectRatio: 1.05,
              child: ShimmerBox(
                width: double.infinity,
                height: double.infinity,
                borderRadius: 0,
              ),
            ),

            // 2. Content Body
            Padding(
              padding: const EdgeInsets.all(AppSpacing.margin),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Category tag
                  const ShimmerBox(
                    width: 70,
                    height: 20,
                    borderRadius: AppSpacing.spaceXs,
                  ),
                  const SizedBox(height: AppSpacing.spaceSm),

                  // Product Title (2 lines)
                  const ShimmerBox(
                    width: double.infinity,
                    height: 22,
                    borderRadius: AppSpacing.spaceXs,
                  ),
                  const SizedBox(height: AppSpacing.spaceXs),
                  const ShimmerBox(
                    width: 200,
                    height: 22,
                    borderRadius: AppSpacing.spaceXs,
                  ),
                  const SizedBox(height: AppSpacing.space12),

                  // Rating row
                  Row(
                    children: const [
                      ShimmerBox(
                        width: 80,
                        height: 16,
                        borderRadius: AppSpacing.spaceXs,
                      ),
                      SizedBox(width: AppSpacing.space12),
                      ShimmerBox(
                        width: 110,
                        height: 16,
                        borderRadius: AppSpacing.spaceXs,
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.margin),

                  // Price
                  const ShimmerBox(
                    width: 140,
                    height: 26,
                    borderRadius: AppSpacing.spaceXs,
                  ),
                  const SizedBox(height: AppSpacing.spaceLg),

                  // Divider
                  const Divider(),
                  const SizedBox(height: AppSpacing.space12),

                  // Variants Selector Section (Colors / Sizes)
                  const ShimmerBox(
                    width: 90,
                    height: 14,
                    borderRadius: AppSpacing.spaceXs,
                  ),
                  const SizedBox(height: AppSpacing.spaceSm),
                  Row(
                    children: const [
                      ShimmerBox(
                        width: 44,
                        height: 36,
                        borderRadius: AppSpacing.spaceSm,
                      ),
                      SizedBox(width: AppSpacing.spaceSm),
                      ShimmerBox(
                        width: 44,
                        height: 36,
                        borderRadius: AppSpacing.spaceSm,
                      ),
                      SizedBox(width: AppSpacing.spaceSm),
                      ShimmerBox(
                        width: 44,
                        height: 36,
                        borderRadius: AppSpacing.spaceSm,
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.margin),

                  // Specifications Card Skeleton
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(AppSpacing.margin),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(AppSpacing.spaceMd),
                      border: Border.all(
                        color: Colors.black.withValues(alpha: 0.04),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        ShimmerBox(
                          width: 120,
                          height: 16,
                          borderRadius: AppSpacing.spaceXs,
                        ),
                        SizedBox(height: AppSpacing.space12),
                        ShimmerBox(
                          width: double.infinity,
                          height: 12,
                          borderRadius: AppSpacing.spaceXs,
                        ),
                        SizedBox(height: AppSpacing.spaceXs),
                        ShimmerBox(
                          width: double.infinity,
                          height: 12,
                          borderRadius: AppSpacing.spaceXs,
                        ),
                        SizedBox(height: AppSpacing.spaceXs),
                        ShimmerBox(
                          width: 220,
                          height: 12,
                          borderRadius: AppSpacing.spaceXs,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: AppSpacing.spaceXl * 2),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
