import 'package:aura/core/theme/app_colors.dart';
import 'package:aura/core/theme/app_typography.dart';
import 'package:flutter/material.dart';

class TrackingMapCourierOverlay extends StatelessWidget {
  final String courierName;
  final String statusText;

  const TrackingMapCourierOverlay({
    super.key,
    this.courierName = 'Marcus Vance',
    this.statusText = 'Vault Courier • 12 mins away',
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.spaceMd,
        vertical: AppSpacing.spaceSm + 2,
      ),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(AppSpacing.spaceMd),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 16,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 38,
            height: 38,
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
          const SizedBox(width: AppSpacing.spaceSm + 2),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    Text(
                      courierName,
                      style: AppTypography.bodyMd.copyWith(
                        fontWeight: FontWeight.w700,
                        color: AppColors.slateHeadline,
                      ),
                    ),
                    const SizedBox(width: 4),
                    const Icon(
                      Icons.verified_rounded,
                      size: 14,
                      color: AppColors.secondary,
                    ),
                  ],
                ),
                Text(
                  statusText,
                  style: AppTypography.bodySm.copyWith(
                    color: AppColors.slateBody,
                    fontSize: 11.5,
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              color: AppColors.surfaceContainerLow,
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.near_me_rounded,
              size: 16,
              color: AppColors.primaryContainer,
            ),
          ),
        ],
      ),
    );
  }
}
