import 'package:aura/core/theme/app_colors.dart';
import 'package:aura/core/theme/app_typography.dart';
import 'package:flutter/material.dart';

class OrderSummaryLineRow extends StatelessWidget {
  final String label;
  final String value;
  final Color? valueColor;
  final String? badgeText;
  final IconData? icon;

  const OrderSummaryLineRow({
    super.key,
    required this.label,
    required this.value,
    this.valueColor,
    this.badgeText,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Text(
              label,
              style: AppTypography.bodyMd.copyWith(
                color: AppColors.onSurfaceVariant,
              ),
            ),
            if (icon != null) ...[
              const SizedBox(width: AppSpacing.spaceXs),
              Icon(icon, size: 13, color: AppColors.secondary),
            ],
          ],
        ),
        Row(
          children: [
            if (badgeText != null) ...[
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.spaceSm,
                  vertical: 2,
                ),
                decoration: BoxDecoration(
                  color: AppColors.secondaryContainer.withValues(alpha: 0.35),
                  borderRadius: BorderRadius.circular(AppSpacing.spaceXs),
                ),
                child: Text(
                  badgeText!,
                  style: AppTypography.labelCaps.copyWith(
                    color: AppColors.secondary,
                    fontWeight: FontWeight.w800,
                    fontSize: 9,
                  ),
                ),
              ),
              const SizedBox(width: AppSpacing.spaceSm),
            ],
            Text(
              value,
              style: AppTypography.bodyMd.copyWith(
                color: valueColor ?? AppColors.slateHeadline,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
