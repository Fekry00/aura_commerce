import 'package:aura/core/theme/app_colors.dart';
import 'package:aura/core/theme/app_typography.dart';
import 'package:flutter/material.dart';

class WishlistSortingActionBar extends StatelessWidget {
  final String sortLabel;
  final VoidCallback? onSortTap;
  final VoidCallback? onMoveAllToBagTap;

  const WishlistSortingActionBar({
    super.key,
    this.sortLabel = 'Price: High to Low',
    this.onSortTap,
    this.onMoveAllToBagTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.margin),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
            onTap: onSortTap,
            borderRadius: BorderRadius.circular(AppSpacing.spaceSm),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: AppSpacing.spaceXs),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Icons.swap_vert,
                    size: AppSpacing.gutter + 2,
                    color: AppColors.onSurfaceVariant,
                  ),
                  const SizedBox(width: AppSpacing.spaceXs),
                  Text(
                    sortLabel,
                    style: AppTypography.labelSm.copyWith(
                      color: AppColors.onSurfaceVariant,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ),
          InkWell(
            onTap: onMoveAllToBagTap,
            borderRadius: BorderRadius.circular(AppSpacing.spaceSm),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: AppSpacing.spaceXs),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Icons.shopping_bag_outlined,
                    size: AppSpacing.spaceMd,
                    color: AppColors.secondary,
                  ),
                  const SizedBox(width: AppSpacing.spaceXs),
                  Text(
                    'Move All to Bag',
                    style: AppTypography.labelSm.copyWith(
                      color: AppColors.secondary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
