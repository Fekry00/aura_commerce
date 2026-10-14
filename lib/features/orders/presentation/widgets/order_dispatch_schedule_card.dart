import 'package:aura/core/theme/app_colors.dart';
import 'package:aura/core/theme/app_typography.dart';
import 'package:flutter/material.dart';

class OrderDispatchScheduleCard extends StatelessWidget {
  final String dateText;

  const OrderDispatchScheduleCard({
    super.key,
    this.dateText = 'May 16 – 17, 2026',
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.spaceMd),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(AppSpacing.spaceMd),
        border: Border.all(
          color: AppColors.outlineVariant.withValues(alpha: 0.5),
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: AppColors.surfaceContainerLow,
              borderRadius: BorderRadius.circular(AppSpacing.spaceSm),
            ),
            child: const Icon(
              Icons.local_shipping_outlined,
              size: 20,
              color: AppColors.primaryContainer,
            ),
          ),
          const SizedBox(width: AppSpacing.spaceMd),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'DISPATCH SCHEDULE',
                  style: AppTypography.labelCaps.copyWith(
                    color: AppColors.slateBody,
                    fontSize: 10,
                    letterSpacing: 0.9,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  dateText,
                  style: AppTypography.bodyMd.copyWith(
                    color: AppColors.slateHeadline,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.spaceSm + 2,
              vertical: AppSpacing.spaceXs,
            ),
            decoration: BoxDecoration(
              color: AppColors.secondaryContainer.withValues(alpha: 0.35),
              borderRadius: BorderRadius.circular(AppSpacing.margin),
            ),
            child: Text(
              'Armored Escort',
              style: AppTypography.labelCaps.copyWith(
                color: AppColors.secondary,
                fontWeight: FontWeight.w700,
                fontSize: 9.5,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
