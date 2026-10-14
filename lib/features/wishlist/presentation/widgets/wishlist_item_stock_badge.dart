import 'package:aura/core/theme/app_colors.dart';
import 'package:aura/core/theme/app_typography.dart';
import 'package:flutter/material.dart';

class WishlistItemStockBadge extends StatelessWidget {
  final String status;
  final bool isLowStock;
  final bool hasComplimentary;

  const WishlistItemStockBadge({
    super.key,
    required this.status,
    this.isLowStock = false,
    this.hasComplimentary = false,
  });

  @override
  Widget build(BuildContext context) {
    final statusColor =
        isLowStock ? AppColors.error : AppColors.onSurfaceVariant;
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (hasComplimentary)
          const Icon(Icons.auto_awesome, size: 14, color: AppColors.secondary)
        else
          Container(
            width: AppSpacing.spaceSm - 2,
            height: AppSpacing.spaceSm - 2,
            decoration: BoxDecoration(
              color: isLowStock ? AppColors.error : AppColors.secondary,
              shape: BoxShape.circle,
            ),
          ),
        const SizedBox(width: AppSpacing.spaceXs + 2),
        Flexible(
          child: Text(
            status,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: AppTypography.labelSm.copyWith(
              color: statusColor,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }
}
