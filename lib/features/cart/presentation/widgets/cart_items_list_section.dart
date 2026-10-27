import 'package:aura/core/theme/app_typography.dart';
import 'package:aura/features/cart/presentation/controllers/cart_controller.dart';
import 'package:aura/features/cart/presentation/widgets/cart_item_card.dart';
import 'package:flutter/material.dart';

/// Pure declarative list section rendering cart items and delegating actions to controller.
class CartItemsListSection extends StatelessWidget {
  final CartController controller;
  final ValueChanged<CartItemUiModel>? onIncrement;
  final ValueChanged<CartItemUiModel>? onDecrement;
  final ValueChanged<CartItemUiModel>? onRemove;

  const CartItemsListSection({
    super.key,
    required this.controller,
    this.onIncrement,
    this.onDecrement,
    this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    final list = controller.items;

    return Column(
      children: List.generate(list.length, (index) {
        final item = list[index];
        return Padding(
          padding: EdgeInsets.only(
            bottom: index == list.length - 1
                ? 0
                : AppSpacing.spaceMd - 2,
          ),
          child: CartItemCard(
            item: item,
            onIncrement: () => onIncrement != null
                ? onIncrement!(item)
                : controller.onIncrement(context, item),
            onDecrement: () => onDecrement != null
                ? onDecrement!(item)
                : controller.onDecrement(context, item),
            onRemove: () => onRemove != null
                ? onRemove!(item)
                : controller.onRemove(context, item),
          ),
        );
      }),
    );
  }
}
