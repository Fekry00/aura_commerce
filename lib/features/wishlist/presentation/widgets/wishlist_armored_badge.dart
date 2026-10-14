import 'package:aura/core/theme/app_colors.dart';
import 'package:aura/core/theme/app_typography.dart';
import 'package:flutter/material.dart';

class WishlistArmoredBadge extends StatelessWidget {
  const WishlistArmoredBadge({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.spaceSm,
        vertical: AppSpacing.spaceXs,
      ),
      decoration: BoxDecoration(
        color: AppColors.surface.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(AppSpacing.spaceLg),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(
            Icons.verified_user_outlined,
            size: AppSpacing.gutter - 1,
            color: AppColors.mintHighlight,
          ),
          const SizedBox(width: AppSpacing.spaceXs),
          Text(
            'Armored Delivery',
            style: AppTypography.labelCaps.copyWith(
              fontSize: 10,
              color: AppColors.onPrimary,
            ),
          ),
        ],
      ),
    );
  }
}
