import 'package:aura/core/theme/app_typography.dart';
import 'package:aura/features/cart/presentation/widgets/cart_controller.dart';
import 'package:aura/features/cart/presentation/widgets/cart_item_card.dart';
import 'package:flutter/material.dart';

class CartItemsListSection extends StatelessWidget {
  final CartController? controller;
  final List<CartItemUiModel>? items;
  final ValueChanged<int>? onIncrement;
  final ValueChanged<int>? onDecrement;
  final ValueChanged<int>? onRemove;

  const CartItemsListSection({
    super.key,
    this.controller,
    this.items,
    this.onIncrement,
    this.onDecrement,
    this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    final list = items ?? controller?.items ?? const [];

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
                ? onIncrement!(index)
                : controller?.incrementQuantity(index),
            onDecrement: () => onDecrement != null
                ? onDecrement!(index)
                : controller?.decrementQuantity(index),
            onRemove: () => onRemove != null
                ? onRemove!(index)
                : controller?.removeItem(index),
          ),
        );
      }),
    );
  }
}
