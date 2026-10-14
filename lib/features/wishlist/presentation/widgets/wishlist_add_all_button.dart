import 'package:aura/core/theme/app_colors.dart';
import 'package:aura/core/theme/app_typography.dart';
import 'package:flutter/material.dart';

class WishlistAddAllButton extends StatelessWidget {
  final VoidCallback? onPressed;

  const WishlistAddAllButton({super.key, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: AppSpacing.spaceXl + AppSpacing.spaceSm,
      child: ElevatedButton.icon(
        onPressed: onPressed,
        icon: const Icon(
          Icons.local_mall_outlined,
          size: AppSpacing.spaceMd + 4,
          color: AppColors.primary,
        ),
        label: Text(
          'Add All Available to Cart',
          style: AppTypography.headlineSm.copyWith(
            fontSize: 16,
            fontWeight: FontWeight.w700,
            color: AppColors.primary,
          ),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.secondaryContainer,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSpacing.spaceLg),
          ),
        ),
      ),
    );
  }
}
