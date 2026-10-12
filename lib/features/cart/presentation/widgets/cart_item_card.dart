import 'package:aura/core/theme/app_colors.dart';
import 'package:aura/core/theme/app_typography.dart';
import 'package:flutter/material.dart';

class CartItemUiModel {
  final String id;
  final String category;
  final String title;
  final String subtitle;
  final double unitPrice;
  final int quantity;
  final String imageUrl;

  const CartItemUiModel({
    required this.id,
    required this.category,
    required this.title,
    required this.subtitle,
    required this.unitPrice,
    required this.quantity,
    required this.imageUrl,
  });

  CartItemUiModel copyWith({int? quantity}) {
    return CartItemUiModel(
      id: id,
      category: category,
      title: title,
      subtitle: subtitle,
      unitPrice: unitPrice,
      quantity: quantity ?? this.quantity,
      imageUrl: imageUrl,
    );
  }

  double get totalPrice => unitPrice * quantity;

  String get formattedPrice {
    final parts = (unitPrice * quantity).toStringAsFixed(2).split('.');
    final intPart = parts[0].replaceAllMapped(
      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
      (Match m) => '${m[1]},',
    );
    return '\$$intPart.${parts[1]}';
  }
}

class CartItemCard extends StatelessWidget {
  final CartItemUiModel item;
  final VoidCallback? onIncrement;
  final VoidCallback? onDecrement;
  final VoidCallback? onRemove;

  const CartItemCard({
    super.key,
    required this.item,
    this.onIncrement,
    this.onDecrement,
    this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(AppSpacing.spaceMd),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: AppSpacing.spaceSm + AppSpacing.spaceXs / 2,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      padding: const EdgeInsets.all(AppSpacing.spaceMd - 2),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Thumbnail Image
          ClipRRect(
            borderRadius: BorderRadius.circular(
              AppSpacing.spaceSm + AppSpacing.spaceXs,
            ),
            child: Container(
              width: 80,
              height: 96,
              color: AppColors.surfaceContainer,
              child: Image.network(
                item.imageUrl,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Container(
                  color: AppColors.surfaceContainerHigh,
                  child: const Icon(
                    Icons.inventory_2_outlined,
                    color: AppColors.slateBody,
                    size: AppSpacing.spaceLg,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(width: AppSpacing.spaceMd - 2),
          Expanded(
            child: SizedBox(
              height: 96,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Top info with delete button
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              item.category,
                              style: AppTypography.labelCaps.copyWith(
                                color: AppColors.onSurfaceVariant,
                              ),
                            ),
                            const SizedBox(height: AppSpacing.spaceXs / 2),
                            Text(
                              item.title,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: AppTypography.headlineSm.copyWith(
                                fontSize: 15,
                                color: AppColors.onSurface,
                              ),
                            ),
                            const SizedBox(height: AppSpacing.spaceXs / 2),
                            Text(
                              item.subtitle,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: AppTypography.bodySm.copyWith(
                                color: AppColors.onSurfaceVariant,
                              ),
                            ),
                          ],
                        ),
                      ),
                      InkWell(
                        onTap: onRemove,
                        borderRadius: BorderRadius.circular(AppSpacing.margin),
                        child: const Padding(
                          padding: EdgeInsets.all(AppSpacing.spaceXs),
                          child: Icon(
                            Icons.close_rounded,
                            size: AppSpacing.spaceMd + 2,
                            color: AppColors.outline,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        item.formattedPrice,
                        style: AppTypography.priceCatalog.copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: AppSpacing.spaceXs,
                          vertical: AppSpacing.spaceXs / 2,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.surfaceContainerHigh,
                          borderRadius: BorderRadius.circular(
                            AppSpacing.margin,
                          ),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            _buildStepperButton(
                              icon: Icons.remove,
                              onTap: onDecrement,
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: AppSpacing.spaceSm,
                              ),
                              child: Text(
                                '${item.quantity}',
                                style: AppTypography.bodySm.copyWith(
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.onSurface,
                                ),
                              ),
                            ),
                            _buildStepperButton(
                              icon: Icons.add,
                              onTap: onIncrement,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStepperButton({required IconData icon, VoidCallback? onTap}) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(
        AppSpacing.spaceSm + AppSpacing.spaceXs,
      ),
      child: Container(
        width: AppSpacing.spaceLg,
        height: AppSpacing.spaceLg,
        alignment: Alignment.center,
        child: Icon(icon, size: AppSpacing.spaceMd, color: AppColors.onSurface),
      ),
    );
  }
}
