import 'package:aura/core/theme/app_colors.dart';
import 'package:aura/core/theme/app_typography.dart';
import 'package:flutter/material.dart';

class WishlistMoveToBagButton extends StatelessWidget {
  final VoidCallback? onPressed;

  const WishlistMoveToBagButton({super.key, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: AppSpacing.spaceXl - 2,
      child: ElevatedButton.icon(
        onPressed: onPressed,
        icon: const Icon(
          Icons.add_shopping_cart,
          size: AppSpacing.gutter,
          color: AppColors.onPrimary,
        ),
        label: Text(
          'Move to Bag',
          style: AppTypography.labelSm.copyWith(
            fontWeight: FontWeight.w600,
            color: AppColors.onPrimary,
          ),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primaryContainer,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSpacing.spaceLg),
          ),
          padding: EdgeInsets.zero,
        ),
      ),
    );
  }
}
