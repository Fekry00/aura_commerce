import 'package:aura/core/theme/app_colors.dart';
import 'package:aura/core/theme/app_typography.dart';
import 'package:aura/core/widgets/shimmer/app_shimmer.dart';
import 'package:flutter/material.dart';

/// Shimmer Skeleton for Order Tracking and Order Details Screen
class OrderDetailsShimmer extends StatelessWidget {
  const OrderDetailsShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.gutter,
        vertical: AppSpacing.space12,
      ),
      child: Column(
        children: [
          // 1. Status Header Card
          Container(
            padding: const EdgeInsets.all(AppSpacing.margin),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(AppSpacing.margin),
              border: Border.all(
                color: AppColors.outlineVariant.withValues(alpha: 0.6),
              ),
            ),
            child: AppShimmer(
              child: Column(
                children: const [
                  ShimmerBox.circular(size: 56),
                  SizedBox(height: AppSpacing.space12),
                  ShimmerBox(
                    width: 150,
                    height: 20,
                    borderRadius: AppSpacing.spaceXs,
                  ),
                  SizedBox(height: AppSpacing.spaceXs),
                  ShimmerBox(
                    width: 100,
                    height: 12,
                    borderRadius: AppSpacing.spaceXs,
                  ),
                  SizedBox(height: AppSpacing.space12),
                  ShimmerBox(
                    width: 90,
                    height: 24,
                    borderRadius: AppSpacing.margin,
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.space12),

          // 2. Order Manifest Card
          Container(
            padding: const EdgeInsets.all(AppSpacing.gutter),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(AppSpacing.spaceMd),
              border: Border.all(
                color: AppColors.outlineVariant.withValues(alpha: 0.6),
              ),
            ),
            child: AppShimmer(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      ShimmerBox(
                        width: 110,
                        height: 14,
                        borderRadius: AppSpacing.spaceXs,
                      ),
                      ShimmerBox(
                        width: 60,
                        height: 14,
                        borderRadius: AppSpacing.spaceXs,
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.space12),
                  ...List.generate(
                    2,
                    (index) => Padding(
                      padding: const EdgeInsets.only(bottom: AppSpacing.space12),
                      child: Row(
                        children: const [
                          ShimmerBox(
                            width: 52,
                            height: 52,
                            borderRadius: AppSpacing.spaceSm,
                          ),
                          SizedBox(width: AppSpacing.space12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ShimmerBox(
                                  width: double.infinity,
                                  height: 14,
                                  borderRadius: AppSpacing.spaceXs,
                                ),
                                SizedBox(height: AppSpacing.spaceXs),
                                ShimmerBox(
                                  width: 80,
                                  height: 10,
                                  borderRadius: AppSpacing.spaceXs,
                                ),
                              ],
                            ),
                          ),
                          SizedBox(width: AppSpacing.spaceSm),
                          ShimmerBox(
                            width: 60,
                            height: 14,
                            borderRadius: AppSpacing.spaceXs,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.space12),

          // 3. Consignment Card
          Container(
            padding: const EdgeInsets.all(AppSpacing.gutter),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(AppSpacing.spaceMd),
              border: Border.all(
                color: AppColors.outlineVariant.withValues(alpha: 0.6),
              ),
            ),
            child: AppShimmer(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  ShimmerBox(
                    width: 160,
                    height: 14,
                    borderRadius: AppSpacing.spaceXs,
                  ),
                  SizedBox(height: AppSpacing.space12),
                  ShimmerBox(
                    width: double.infinity,
                    height: 14,
                    borderRadius: AppSpacing.spaceXs,
                  ),
                  SizedBox(height: AppSpacing.spaceXs),
                  ShimmerBox(
                    width: 120,
                    height: 12,
                    borderRadius: AppSpacing.spaceXs,
                  ),
                  SizedBox(height: AppSpacing.spaceSm),
                  ShimmerBox(
                    width: 100,
                    height: 20,
                    borderRadius: AppSpacing.spaceXs,
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.space12),

          // 4. Settlement Summary Card
          Container(
            padding: const EdgeInsets.all(AppSpacing.gutter),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(AppSpacing.spaceMd),
              border: Border.all(
                color: AppColors.outlineVariant.withValues(alpha: 0.6),
              ),
            ),
            child: AppShimmer(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  ShimmerBox(
                    width: 140,
                    height: 14,
                    borderRadius: AppSpacing.spaceXs,
                  ),
                  SizedBox(height: AppSpacing.space12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ShimmerBox(
                        width: 80,
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
                  Divider(),
                  SizedBox(height: AppSpacing.spaceSm),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ShimmerBox(
                        width: 90,
                        height: 16,
                        borderRadius: AppSpacing.spaceXs,
                      ),
                      ShimmerBox(
                        width: 80,
                        height: 18,
                        borderRadius: AppSpacing.spaceXs,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.spaceLg),
        ],
      ),
    );
  }
}
