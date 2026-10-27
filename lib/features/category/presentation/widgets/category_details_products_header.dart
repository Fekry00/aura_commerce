import 'package:aura/core/theme/app_colors.dart';
import 'package:aura/core/theme/app_typography.dart';
import 'package:flutter/material.dart';

class CategoryDetailsProductsHeader extends StatelessWidget {
  const CategoryDetailsProductsHeader({
    super.key,
    required this.productsCount,
  });

  final int productsCount;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Curated Catalog ($productsCount)',
            style: AppTypography.headlineSm.copyWith(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF002419),
            ),
          ),
          Row(
            children: [
              const Icon(
                Icons.swap_vert_rounded,
                size: 16,
                color: AppColors.slateBody,
              ),
              const SizedBox(width: 4),
              Text(
                'Sort: Featured',
                style: AppTypography.labelSm.copyWith(
                  color: AppColors.slateBody,
                  fontSize: 11,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
