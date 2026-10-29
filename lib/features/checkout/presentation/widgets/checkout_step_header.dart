import 'package:aura/core/theme/app_colors.dart';
import 'package:aura/core/theme/app_typography.dart';
import 'package:flutter/material.dart';

class CheckoutStepHeader extends StatelessWidget {
  const CheckoutStepHeader({
    super.key,
    this.stepNumber = '1',
    this.stepTitle = 'SHIPPING & SETTLEMENT',
    this.stepSubtitle = 'Verify destination and payment protocol',
  });

  final String stepNumber;
  final String stepTitle;
  final String stepSubtitle;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.spaceMd, vertical: AppSpacing.space12),
      decoration: BoxDecoration(
        color: const Color(0xFF0B3B2C).withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(AppSpacing.spaceMd),
        border: Border.all(
          color: const Color(0xFF0B3B2C).withValues(alpha: 0.15),
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 28,
            height: 28,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Color(0xFF0B3B2C),
            ),
            child: Center(
              child: Text(
                stepNumber,
                style: AppTypography.labelCaps.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
          const SizedBox(width: AppSpacing.space12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  stepTitle,
                  style: AppTypography.labelCaps.copyWith(
                    color: const Color(0xFF0B3B2C),
                    fontWeight: FontWeight.w800,
                    fontSize: 10,
                    letterSpacing: 1.2,
                  ),
                ),
                const SizedBox(height: AppSpacing.space2Xs),
                Text(
                  stepSubtitle,
                  style: AppTypography.bodySm.copyWith(
                    color: AppColors.slateBody,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
