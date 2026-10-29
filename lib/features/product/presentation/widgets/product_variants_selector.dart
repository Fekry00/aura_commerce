import 'package:aura/core/theme/app_colors.dart';
import 'package:aura/core/theme/app_typography.dart';
import 'package:aura/features/product/domain/entities/sub_entities/product_item_entity.dart';
import 'package:flutter/material.dart';

class ProductVariantsSelector extends StatelessWidget {
  final int selectedColorIndex;
  final int selectedSizeIndex;
  final List<Color>? colors;
  final List<String>? sizes;
  final ProductItemEntity? product;
  final ValueChanged<int>? onColorSelected;
  final ValueChanged<int>? onSizeSelected;
  final VoidCallback? onSizingGuideTap;

  const ProductVariantsSelector({
    super.key,
    this.selectedColorIndex = 0,
    this.selectedSizeIndex = 0,
    this.colors,
    this.sizes,
    this.product,
    this.onColorSelected,
    this.onSizeSelected,
    this.onSizingGuideTap,
  });

  static const List<Color> defaultColors = [
    Color(0xFF1E293B),
    Color(0xFFD6D6D6),
    Color(0xFFC5A07C),
  ];

  static List<String> getSizesForProduct(ProductItemEntity? product) {
    if (product == null) {
      return const ['Standard Edition', 'Limited Reserve', 'Bespoke Atelier'];
    }
    final category = product.categoryName?.toLowerCase() ?? '';
    final name = product.name.toLowerCase();

    if (category.contains('clothing') ||
        category.contains('apparel') ||
        name.contains('shirt') ||
        name.contains('jacket') ||
        name.contains('coat') ||
        name.contains('hoodie')) {
      return const ['Small', 'Medium', 'Large', 'X-Large'];
    }
    return const ['Standard Edition', 'Limited Reserve', 'Bespoke Atelier'];
  }

  static String getSizeSectionLabel(ProductItemEntity? product) {
    if (product == null) return 'EDITION & SPECIFICATION';
    final category = product.categoryName?.toLowerCase() ?? '';
    final name = product.name.toLowerCase();

    if (category.contains('watch') ||
        name.contains('watch') ||
        name.contains('chronograph')) {
      return 'CASE DIMENSION';
    } else if (category.contains('shoe') || name.contains('shoe')) {
      return 'SHOE SIZE';
    } else if (category.contains('ring') || name.contains('ring')) {
      return 'CIRCUMFERENCE';
    } else if (category.contains('clothing') ||
        category.contains('apparel')) {
      return 'GARMENT SIZE';
    } else if (category.contains('electronic') ||
        category.contains('tech')) {
      return 'STORAGE CAPACITY';
    } else if (category.contains('perfume') ||
        category.contains('fragrance')) {
      return 'VOLUME';
    }
    return 'EDITION & SPECIFICATION';
  }

  @override
  Widget build(BuildContext context) {
    final effectiveColors = (colors != null && colors!.isNotEmpty)
        ? colors!
        : defaultColors;
    final effectiveSizes = (sizes != null && sizes!.isNotEmpty)
        ? sizes!
        : getSizesForProduct(product);
    final sizeLabel = getSizeSectionLabel(product);

    final safeSizeIndex = (selectedSizeIndex >= effectiveSizes.length)
        ? 0
        : selectedSizeIndex;
    final safeColorIndex = (selectedColorIndex >= effectiveColors.length)
        ? 0
        : selectedColorIndex;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'COLOR & FINISHES',
          style: AppTypography.labelCaps.copyWith(color: AppColors.slateBody),
        ),
        const SizedBox(height: AppSpacing.spaceSm),
        Row(
          children: List.generate(effectiveColors.length, (index) {
            final isSelected = safeColorIndex == index;
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
                    color: effectiveColors[index],
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
              sizeLabel,
              style: AppTypography.labelCaps.copyWith(color: AppColors.slateBody),
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
                    'Sizing Guide',
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
          children: List.generate(effectiveSizes.length, (index) {
            final isSelected = safeSizeIndex == index;
            return Expanded(
              child: GestureDetector(
                onTap: () => onSizeSelected?.call(index),
                child: Container(
                  margin: EdgeInsets.only(
                    right: index == effectiveSizes.length - 1
                        ? 0
                        : AppSpacing.spaceSm,
                  ),
                  padding: const EdgeInsets.symmetric(
                    vertical: AppSpacing.spaceSm + AppSpacing.spaceXs,
                  ),
                  decoration: BoxDecoration(
                    color: isSelected ? AppColors.primaryContainer : Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: isSelected
                          ? AppColors.primaryContainer
                          : AppColors.outlineVariant,
                    ),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    isSelected
                        ? '${effectiveSizes[index]} • Active'
                        : effectiveSizes[index],
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