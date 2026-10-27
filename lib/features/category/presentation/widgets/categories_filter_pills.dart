import 'package:aura/core/theme/app_colors.dart';
import 'package:aura/core/theme/app_typography.dart';
import 'package:flutter/material.dart';

class CategoriesFilterPills extends StatelessWidget {
  const CategoriesFilterPills({
    super.key,
    required this.pills,
    required this.selectedIndex,
    required this.onPillSelected,
  });

  final List<String> pills;
  final int selectedIndex;
  final void Function(int index, String pillText) onPillSelected;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 2),
      child: Row(
        children: List.generate(pills.length, (index) {
          final isSelected = selectedIndex == index;
          final pillText = pills[index];
          return GestureDetector(
            onTap: () => onPillSelected(index, pillText),
            child: Container(
              margin: const EdgeInsets.only(right: 8),
              padding: const EdgeInsets.symmetric(
                horizontal: 14,
                vertical: 7,
              ),
              decoration: BoxDecoration(
                color: isSelected
                    ? const Color(0xFF0B3B2C)
                    : AppColors.surfaceContainerLow,
                borderRadius: BorderRadius.circular(20),
                boxShadow: isSelected
                    ? [
                        BoxShadow(
                          color: const Color(0xFF0B3B2C).withValues(alpha: 0.2),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ]
                    : null,
              ),
              child: Text(
                pillText,
                style: AppTypography.labelSm.copyWith(
                  color: isSelected ? Colors.white : AppColors.onSurfaceVariant,
                  fontSize: 12,
                  fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
