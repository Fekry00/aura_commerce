import 'package:aura/core/theme/app_colors.dart';
import 'package:aura/core/theme/app_typography.dart';
import 'package:aura/features/product/presentation/utils/product_ui_helper.dart';
import 'package:flutter/material.dart';

class ProductDetailsInfoSection extends StatelessWidget {
  final String? categoryName;
  final String title;
  final String price;
  final String? comparePrice;
  final bool inStock;
  final String description;

  const ProductDetailsInfoSection({
    super.key,
    this.categoryName,
    required this.title,
    required this.price,
    this.comparePrice,
    required this.inStock,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (categoryName != null && categoryName!.isNotEmpty) ...[
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 4,
            ),
            decoration: BoxDecoration(
              color: const Color(0xFF1E382B).withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              categoryName!.toUpperCase(),
              style: AppTypography.labelCaps.copyWith(
                color: const Color(0xFF1E382B),
                fontSize: 10,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.spaceSm),
        ],
        Text(
          title,
          style: AppTypography.headlineSm.copyWith(
            fontWeight: FontWeight.w800,
          ),
        ),
        const SizedBox(height: AppSpacing.spaceSm),
        Row(
          children: [
            Text(
              price,
              style: AppTypography.priceHero,
            ),
            if (comparePrice != null) ...[
              const SizedBox(width: AppSpacing.spaceSm),
              Text(
                comparePrice!,
                style: AppTypography.bodySm.copyWith(
                  color: AppColors.slateBody,
                  decoration: TextDecoration.lineThrough,
                ),
              ),
            ],
            const SizedBox(width: AppSpacing.spaceSm + 2),
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.spaceSm,
                vertical: AppSpacing.spaceXs - 1,
              ),
              decoration: BoxDecoration(
                color: ProductUiHelper.getStockBadgeBg(inStock),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                ProductUiHelper.getStockBadgeText(inStock),
                style: AppTypography.labelCaps.copyWith(
                  color: ProductUiHelper.getStockBadgeColor(inStock),
                  fontSize: 10,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.spaceMd),
        Text(
          description,
          style: AppTypography.bodySm.copyWith(
            color: AppColors.slateBody,
            height: 1.5,
          ),
        ),
      ],
    );
  }
}
