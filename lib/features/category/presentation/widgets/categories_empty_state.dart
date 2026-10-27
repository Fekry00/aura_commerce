import 'package:aura/core/theme/app_colors.dart';
import 'package:aura/core/theme/app_typography.dart';
import 'package:flutter/material.dart';

class CategoriesEmptyState extends StatelessWidget {
  const CategoriesEmptyState({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          children: [
            const Icon(
              Icons.search_off_rounded,
              size: 40,
              color: AppColors.outline,
            ),
            const SizedBox(height: 12),
            Text(
              'No matching collections found',
              style: AppTypography.headlineSm.copyWith(fontSize: 16),
            ),
            const SizedBox(height: 6),
            Text(
              'Try adjusting your search or filters.',
              style: AppTypography.bodySm.copyWith(color: AppColors.slateBody),
            ),
          ],
        ),
      ),
    );
  }
}
