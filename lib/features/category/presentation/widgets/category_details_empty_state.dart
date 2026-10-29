import 'package:aura/core/theme/app_colors.dart';
import 'package:aura/core/theme/app_typography.dart';
import 'package:flutter/material.dart';

class CategoryDetailsEmptyState extends StatelessWidget {
  const CategoryDetailsEmptyState({
    super.key,
    required this.isSubDepartmentFiltered,
    required this.categoryName,
    required this.onResetFilter,
  });

  final bool isSubDepartmentFiltered;
  final String categoryName;
  final VoidCallback onResetFilter;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppSpacing.spaceXl),
      child: Center(
        child: Column(
          children: [
            const Icon(
              Icons.inventory_2_outlined,
              size: 44,
              color: AppColors.outline,
            ),
            const SizedBox(height: AppSpacing.space12),
            Text(
              isSubDepartmentFiltered
                  ? 'No products in this sub-department'
                  : 'No products available in this category',
              style: AppTypography.headlineSm.copyWith(fontSize: 15),
            ),
            const SizedBox(height: AppSpacing.spaceXs),
            Text(
              isSubDepartmentFiltered
                  ? 'Try selecting another department or view all items.'
                  : 'Products added to "$categoryName" will appear here.',
              textAlign: TextAlign.center,
              style: AppTypography.bodySm.copyWith(
                color: AppColors.slateBody,
              ),
            ),
            if (isSubDepartmentFiltered) ...[
              const SizedBox(height: AppSpacing.spaceMd),
              OutlinedButton(
                onPressed: onResetFilter,
                child: Text(
                  'View All in $categoryName',
                  style: AppTypography.labelCaps.copyWith(color: const Color(0xFF0B3B2C)),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
