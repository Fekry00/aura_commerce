import 'package:aura/core/theme/app_colors.dart';
import 'package:aura/core/theme/app_typography.dart';
import 'package:flutter/material.dart';
import 'wishlist_item_data.dart';
import 'wishlist_item_details.dart';
import 'wishlist_item_thumbnail.dart';

class WishlistItemCard extends StatelessWidget {
  final WishlistItemData item;
  final VoidCallback? onRemove;
  final VoidCallback? onMoveToBag;

  const WishlistItemCard({
    super.key,
    required this.item,
    this.onRemove,
    this.onMoveToBag,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(AppSpacing.spaceMd),
        boxShadow: [
          BoxShadow(
            color: AppColors.onSurface.withValues(alpha: 0.04),
            blurRadius: AppSpacing.margin,
            offset: const Offset(0, AppSpacing.spaceXs),
          ),
          BoxShadow(
            color: AppColors.onSurface.withValues(alpha: 0.02),
            blurRadius: AppSpacing.spaceSm - 2,
            offset: const Offset(0, AppSpacing.spaceXs / 2),
          ),
        ],
      ),
      padding: const EdgeInsets.all(AppSpacing.spaceMd),
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            WishlistItemThumbnail(
              imageUrl: item.imageUrl,
              badge: item.badge,
            ),
            const SizedBox(width: AppSpacing.spaceMd),
            Expanded(
              child: WishlistItemDetails(
                item: item,
                onRemove: onRemove,
                onMoveToBag: onMoveToBag,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
