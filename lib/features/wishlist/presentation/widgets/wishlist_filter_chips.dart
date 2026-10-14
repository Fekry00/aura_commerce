import 'package:aura/core/theme/app_colors.dart';
import 'package:aura/core/theme/app_typography.dart';
import 'package:flutter/material.dart';

class WishlistFilterChips extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int>? onSelected;

  const WishlistFilterChips({
    super.key,
    this.selectedIndex = 0,
    this.onSelected,
  });

  static const List<String> _categories = [
    'All (4)',
    'Skin Care',
    'Horlogerie',
    'Leather Goods',
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.margin),
      child: Row(
        children: List.generate(_categories.length, (index) {
          final isSelected = index == selectedIndex;
          return Padding(
            padding: EdgeInsets.only(
              right: index < _categories.length - 1 ? AppSpacing.spaceSm : 0,
            ),
            child: InkWell(
              onTap: () => onSelected?.call(index),
              borderRadius: BorderRadius.circular(AppSpacing.spaceLg),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.spaceMd,
                  vertical: AppSpacing.spaceSm - 1,
                ),
                decoration: BoxDecoration(
                  color: isSelected
                      ? AppColors.primaryContainer
                      : AppColors.surfaceContainerLow,
                  borderRadius: BorderRadius.circular(AppSpacing.spaceLg),
                ),
                child: Text(
                  _categories[index],
                  style: AppTypography.labelSm.copyWith(
                    fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                    color: isSelected
                        ? AppColors.onPrimary
                        : AppColors.onSurfaceVariant,
                  ),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
