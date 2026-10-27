import 'package:aura/core/theme/app_colors.dart';
import 'package:aura/core/theme/app_typography.dart';
import 'package:aura/features/category/domain/entities/category_entity.dart';
import 'package:flutter/material.dart';

class CategoryDetailsSubdepartmentsTabs extends StatelessWidget {
  const CategoryDetailsSubdepartmentsTabs({
    super.key,
    required this.subDepartments,
    required this.selectedIndex,
    required this.onTabSelected,
  });

  final List<SubDepartmentEntity> subDepartments;
  final int selectedIndex;
  final ValueChanged<int> onTabSelected;

  @override
  Widget build(BuildContext context) {
    if (subDepartments.isEmpty) {
      return const SizedBox.shrink();
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Row(
          children: [
            _buildTab(
              title: 'All Items',
              isSelected: selectedIndex == 0,
              onTap: () => onTabSelected(0),
            ),
            ...List.generate(subDepartments.length, (index) {
              final sub = subDepartments[index];
              final isSelected = selectedIndex == index + 1;
              return _buildTab(
                title: sub.name,
                isSelected: isSelected,
                onTap: () => onTabSelected(index + 1),
              );
            }),
          ],
        ),
      ),
    );
  }

  Widget _buildTab({
    required String title,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(right: 8),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
        decoration: BoxDecoration(
          color: isSelected
              ? const Color(0xFF0B3B2C)
              : AppColors.surfaceContainerLow,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected
                ? Colors.transparent
                : AppColors.outlineVariant.withValues(alpha: 0.5),
          ),
        ),
        child: Text(
          title,
          style: AppTypography.labelSm.copyWith(
            color: isSelected ? Colors.white : AppColors.onSurfaceVariant,
            fontSize: 12,
            fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
