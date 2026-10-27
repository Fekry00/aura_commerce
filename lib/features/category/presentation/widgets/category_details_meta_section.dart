import 'package:aura/core/theme/app_colors.dart';
import 'package:aura/core/theme/app_typography.dart';
import 'package:aura/features/category/domain/entities/category_entity.dart';
import 'package:flutter/material.dart';

class CategoryDetailsMetaSection extends StatelessWidget {
  const CategoryDetailsMetaSection({
    super.key,
    required this.category,
    required this.creationsCount,
  });

  final CategoryEntity category;
  final int creationsCount;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 5,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFF6CF8BB).withValues(alpha: 0.25),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 7,
                      height: 7,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color(0xFF00714D),
                      ),
                    ),
                    const SizedBox(width: 6),
                    Text(
                      '$creationsCount CREATIONS',
                      style: AppTypography.labelSm.copyWith(
                        color: const Color(0xFF00714D),
                        fontWeight: FontWeight.w700,
                        fontSize: 10,
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                '#${category.slug}',
                style: AppTypography.bodySm.copyWith(
                  color: AppColors.slateBody,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            category.description?.isNotEmpty == true
                ? category.description!
                : 'Explore exquisite luxury creations from our private catalogue.',
            style: AppTypography.bodySm.copyWith(
              color: AppColors.onSurfaceVariant,
              fontSize: 13,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}
