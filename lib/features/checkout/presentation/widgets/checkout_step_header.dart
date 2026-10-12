import 'package:aura/core/theme/app_colors.dart';
import 'package:aura/core/theme/app_typography.dart';
import 'package:flutter/material.dart';

class CheckoutStepHeader extends StatelessWidget {
  final String stepText;
  final String nextStepText;
  final String title;
  final String badgeText;
  final double progress;

  const CheckoutStepHeader({
    super.key,
    this.stepText = 'STEP 1 OF 2',
    this.nextStepText = 'Next: Payment',
    this.title = 'Shipping & Delivery',
    this.badgeText = 'VIP Privilege Active',
    this.progress = 0.5,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              stepText,
              style: AppTypography.labelCaps.copyWith(
                color: AppColors.secondary,
                fontWeight: FontWeight.w700,
                letterSpacing: 1.0,
              ),
            ),
            Text(
              nextStepText,
              style: AppTypography.labelSm.copyWith(
                color: AppColors.onSurfaceVariant,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.spaceXs + 2),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: AppTypography.headlineSm.copyWith(
                fontWeight: FontWeight.w700,
                color: AppColors.onSurface,
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.spaceSm + AppSpacing.spaceXs / 2,
                vertical: AppSpacing.spaceXs / 2,
              ),
              decoration: BoxDecoration(
                color: AppColors.secondaryContainer.withValues(alpha: 0.35),
                borderRadius: BorderRadius.circular(AppSpacing.margin),
              ),
              child: Text(
                badgeText,
                style: AppTypography.labelCaps.copyWith(
                  color: AppColors.secondary,
                  fontWeight: FontWeight.w700,
                  fontSize: 10,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.spaceSm + 2),
        ClipRRect(
          borderRadius: BorderRadius.circular(AppSpacing.margin),
          child: LinearProgressIndicator(
            value: progress,
            minHeight: 6,
            backgroundColor: AppColors.surfaceContainer,
            valueColor: const AlwaysStoppedAnimation<Color>(
              AppColors.primaryContainer,
            ),
          ),
        ),
      ],
    );
  }
}
