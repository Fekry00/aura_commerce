import 'package:aura/core/theme/app_typography.dart';
import 'package:aura/core/widgets/shimmer/app_shimmer.dart';
import 'package:flutter/material.dart';

class ReviewsShimmerSkeleton extends StatelessWidget {
  const ReviewsShimmerSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return AppShimmer(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.margin),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const ShimmerBox(
              width: double.infinity,
              height: 100,
              borderRadius: 16,
            ),
            const SizedBox(height: AppSpacing.spaceMd),
            const ShimmerBox(
              width: double.infinity,
              height: 130,
              borderRadius: 16,
            ),
            const SizedBox(height: AppSpacing.spaceLg),
            ...List.generate(
              2,
              (index) => Container(
                margin: const EdgeInsets.only(bottom: 12),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        ShimmerBox.circular(size: 40),
                        SizedBox(width: 12),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ShimmerBox(
                              width: 100,
                              height: 14,
                              borderRadius: 4,
                            ),
                            SizedBox(height: 6),
                            ShimmerBox(
                              width: 60,
                              height: 10,
                              borderRadius: 4,
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 12),
                    ShimmerBox(
                      width: double.infinity,
                      height: 12,
                      borderRadius: 4,
                    ),
                    SizedBox(height: 6),
                    ShimmerBox(
                      width: 200,
                      height: 12,
                      borderRadius: 4,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
