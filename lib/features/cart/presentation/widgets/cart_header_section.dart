import 'package:aura/core/theme/app_colors.dart';
import 'package:aura/core/theme/app_typography.dart';
import 'package:flutter/material.dart';

class CartHeaderSection extends StatelessWidget {
  final int itemCount;

  const CartHeaderSection({
    super.key,
    this.itemCount = 3,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.baseline,
      textBaseline: TextBaseline.alphabetic,
      children: [
        Text(
          'Your Bag',
          style: AppTypography.displayHero,
        ),
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.spaceSm + AppSpacing.spaceXs / 2,
            vertical: AppSpacing.spaceXs,
          ),
          decoration: BoxDecoration(
            color: AppColors.secondaryContainer.withValues(alpha: 0.35),
            borderRadius: BorderRadius.circular(AppSpacing.margin),
          ),
          child: Text(
            '$itemCount CURATED ITEMS',
            style: AppTypography.labelCaps.copyWith(
              color: AppColors.secondary,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ],
    );
  }
}
