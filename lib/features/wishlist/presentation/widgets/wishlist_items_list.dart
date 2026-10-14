import 'package:aura/core/theme/app_typography.dart';
import 'package:flutter/material.dart';
import 'wishlist_item_card.dart';
import 'wishlist_item_data.dart';

class WishlistItemsList extends StatelessWidget {
  final List<WishlistItemData> items;
  final ValueChanged<String>? onRemoveItem;
  final ValueChanged<String>? onMoveToBag;

  const WishlistItemsList({
    super.key,
    required this.items,
    this.onRemoveItem,
    this.onMoveToBag,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.margin),
      itemCount: items.length,
      separatorBuilder: (context, index) =>
          const SizedBox(height: AppSpacing.spaceMd),
      itemBuilder: (context, index) {
        final item = items[index];
        return WishlistItemCard(
          item: item,
          onRemove: () => onRemoveItem?.call(item.id),
          onMoveToBag: () => onMoveToBag?.call(item.id),
        );
      },
    );
  }
}
