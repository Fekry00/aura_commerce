import 'package:aura/core/theme/app_typography.dart';
import 'package:aura/features/cart/domain/entities/sub_entities/cart_item_entity.dart';
import 'package:aura/features/cart/presentation/widgets/cart_item_card.dart';
import 'package:flutter/material.dart';

/// Pure declarative list section rendering cart items without controllers.
class CartItemsListSection extends StatelessWidget {
  final List<CartItemEntity> items;
  final ValueChanged<CartItemEntity>? onIncrement;
  final ValueChanged<CartItemEntity>? onDecrement;
  final ValueChanged<CartItemEntity>? onRemove;

  const CartItemsListSection({
    super.key,
    required this.items,
    this.onIncrement,
    this.onDecrement,
    this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(items.length, (index) {
        final item = items[index];
        final uiModel = CartItemUiModel.fromEntity(item);
        return Padding(
          padding: EdgeInsets.only(
            bottom: index == items.length - 1
                ? 0
                : AppSpacing.spaceMd - 2,
          ),
          child: CartItemCard(
            item: uiModel,
            onIncrement: () => onIncrement?.call(item),
            onDecrement: () => onDecrement?.call(item),
            onRemove: () => onRemove?.call(item),
          ),
        );
      }),
    );
  }
}
