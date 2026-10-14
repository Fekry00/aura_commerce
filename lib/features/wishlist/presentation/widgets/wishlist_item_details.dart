import 'package:aura/core/theme/app_colors.dart';
import 'package:aura/core/theme/app_typography.dart';
import 'package:flutter/material.dart';
import 'wishlist_item_data.dart';
import 'wishlist_item_stock_badge.dart';
import 'wishlist_move_to_bag_button.dart';

class WishlistItemDetails extends StatelessWidget {
  final WishlistItemData item;
  final VoidCallback? onRemove;
  final VoidCallback? onMoveToBag;

  const WishlistItemDetails({
    super.key,
    required this.item,
    this.onRemove,
    this.onMoveToBag,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                item.category.toUpperCase(),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: AppTypography.labelCaps.copyWith(
                  color: AppColors.onSurfaceVariant,
                  letterSpacing: 0.8,
                ),
              ),
            ),
            InkWell(
              onTap: onRemove,
              borderRadius: BorderRadius.circular(AppSpacing.margin),
              child: const Padding(
                padding: EdgeInsets.all(AppSpacing.spaceXs / 2),
                child: Icon(Icons.favorite, size: AppSpacing.gutter + 2, color: AppColors.secondary),
              ),
            ),
          ],
        ),
        Text(
          item.title,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: AppTypography.headlineSm.copyWith(
            fontWeight: FontWeight.w600,
            fontSize: 16,
            color: AppColors.onSurface,
          ),
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.baseline,
          textBaseline: TextBaseline.alphabetic,
          children: [
            Text(
              '\$${item.price.toStringAsFixed(2)}',
              style: AppTypography.priceCatalog.copyWith(
                color: AppColors.primary,
                fontWeight: FontWeight.w700,
              ),
            ),
            if (item.originalPrice != null) ...[
              const SizedBox(width: AppSpacing.spaceSm),
              Text(
                '\$${item.originalPrice!.toStringAsFixed(2)}',
                style: AppTypography.bodySm.copyWith(
                  color: AppColors.outline,
                  decoration: TextDecoration.lineThrough,
                ),
              ),
            ],
          ],
        ),
        const SizedBox(height: AppSpacing.spaceXs),
        WishlistItemStockBadge(
          status: item.stockStatus,
          isLowStock: item.isLowStock,
          hasComplimentary: item.hasComplimentary,
        ),
        const SizedBox(height: AppSpacing.spaceSm),
        WishlistMoveToBagButton(onPressed: onMoveToBag),
      ],
    );
  }
}
