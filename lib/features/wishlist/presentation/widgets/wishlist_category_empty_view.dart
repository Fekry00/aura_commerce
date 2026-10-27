import 'package:aura/core/theme/app_colors.dart';
import 'package:aura/core/theme/app_typography.dart';
import 'package:flutter/material.dart';

class WishlistCategoryEmptyView extends StatelessWidget {
  const WishlistCategoryEmptyView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 160,
      alignment: Alignment.center,
      child: Text(
        'No products found in this category',
        style: AppTypography.bodySm.copyWith(
          color: AppColors.onSurfaceVariant,
        ),
      ),
    );
  }
}
