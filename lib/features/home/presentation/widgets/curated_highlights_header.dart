import 'package:aura/core/theme/app_colors.dart';
import 'package:aura/core/theme/app_typography.dart';
import 'package:flutter/material.dart';

class CuratedHighlightsHeader extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int>? onTabChanged;

  const CuratedHighlightsHeader({
    super.key,
    this.selectedIndex = 0,
    this.onTabChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'ICONIC EDITIONS',
          style: AppTypography.labelCaps.copyWith(
            color: AppColors.secondary,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 4),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Curated Highlights',
              style: AppTypography.headlineSm.copyWith(
                fontWeight: FontWeight.w700,
                fontSize: 20,
              ),
            ),
            Container(
              padding: const EdgeInsets.all(3),
              decoration: BoxDecoration(
                color: AppColors.surfaceContainerHigh,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                children: [
                  _HighlightsTabItem(
                    title: 'All',
                    isSelected: selectedIndex == 0,
                    onTap: () => onTabChanged?.call(0),
                  ),
                  _HighlightsTabItem(
                    title: 'Popular',
                    isSelected: selectedIndex == 1,
                    onTap: () => onTabChanged?.call(1),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _HighlightsTabItem extends StatelessWidget {
  final String title;
  final bool isSelected;
  final VoidCallback onTap;

  const _HighlightsTabItem({
    required this.title,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primaryContainer : Colors.transparent,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Text(
          title,
          style: AppTypography.labelSm.copyWith(
            color: isSelected ? Colors.white : AppColors.onSurfaceVariant,
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
            fontSize: 12,
          ),
        ),
      ),
    );
  }
}