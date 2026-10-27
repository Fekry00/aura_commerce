import 'package:aura/core/theme/app_colors.dart';
import 'package:aura/core/theme/app_typography.dart';
import 'package:aura/features/product/presentation/controllers/product_details_controller.dart';
import 'package:flutter/material.dart';

class ProductVariantsSelector extends StatelessWidget {
  final int selectedColorIndex;
  final int selectedSizeIndex;
  final List<Color> colors;
  final List<String> sizes;
  final ValueChanged<int>? onColorSelected;
  final ValueChanged<int>? onSizeSelected;
  final VoidCallback? onSizingGuideTap;

  const ProductVariantsSelector({
    super.key,
    this.selectedColorIndex = 0,
    this.selectedSizeIndex = 1,
    this.colors = ProductDetailsController.colors,
    this.sizes = ProductDetailsController.sizes,
    this.onColorSelected,
    this.onSizeSelected,
    this.onSizingGuideTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'CASE & FINISHES',
          style: AppTypography.labelCaps.copyWith(color: AppColors.slateBody),
        ),
        const SizedBox(height: AppSpacing.spaceSm),
        Row(
          children: List.generate(colors.length, (index) {
            final isSelected = selectedColorIndex == index;
            return GestureDetector(
              onTap: () => onColorSelected?.call(index),
              child: Container(
                margin: const EdgeInsets.only(
                  right: AppSpacing.spaceSm + AppSpacing.spaceXs,
                ),
                padding: const EdgeInsets.all(AppSpacing.spaceXs - 1),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: isSelected
                        ? AppColors.primaryContainer
                        : Colors.transparent,
                    width: 1.5,
                  ),
                ),
                child: Container(
                  width: 24,
                  height: 24,
                  decoration: BoxDecoration(
                    color: colors[index],
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            );
          }),
        ),
        const SizedBox(height: AppSpacing.margin),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'CASE DIMENSION',
              style:
                  AppTypography.labelCaps.copyWith(color: AppColors.slateBody),
            ),
            GestureDetector(
              onTap: onSizingGuideTap,
              child: Row(
                children: [
                  const Icon(
                    Icons.straighten_rounded,
                    size: 14,
                    color: AppColors.slateBody,
                  ),
                  const SizedBox(width: AppSpacing.spaceXs),
                  Text(
                    'Wrist Sizing Guide',
                    style: AppTypography.labelSm.copyWith(
                      color: AppColors.slateBody,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.spaceSm),
        Row(
          children: List.generate(sizes.length, (index) {
            final isSelected = selectedSizeIndex == index;
            return Expanded(
              child: GestureDetector(
                onTap: () => onSizeSelected?.call(index),
                child: Container(
                  margin: EdgeInsets.only(
                    right:
                        index == sizes.length - 1 ? 0 : AppSpacing.spaceSm,
                  ),
                  padding: const EdgeInsets.symmetric(
                    vertical: AppSpacing.spaceSm + AppSpacing.spaceXs,
                  ),
                  decoration: BoxDecoration(
                    color:
                        isSelected ? AppColors.primaryContainer : Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: isSelected
                          ? AppColors.primaryContainer
                          : AppColors.outlineVariant,
                    ),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    isSelected ? '${sizes[index]} • Active' : sizes[index],
                    style: AppTypography.bodySm.copyWith(
                      color: isSelected ? Colors.white : AppColors.onSurface,
                      fontWeight:
                          isSelected ? FontWeight.w700 : FontWeight.w500,
                    ),
                  ),
                ),
              ),
            );
          }),
        ),
      ],
    );
  }
}