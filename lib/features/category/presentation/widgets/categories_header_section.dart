import 'package:aura/core/theme/app_colors.dart';
import 'package:aura/core/theme/app_typography.dart';
import 'package:flutter/material.dart';

class CategoriesHeaderSection extends StatelessWidget {
  const CategoriesHeaderSection({
    super.key,
    required this.departmentsCount,
  });

  final int departmentsCount;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 4, 16, 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'AURA CURATED PORTFOLIOS',
                style: AppTypography.labelSm.copyWith(
                  color: AppColors.secondary,
                  fontSize: 10,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 1.5,
                ),
              ),
              Row(
                children: [
                  Container(
                    width: 6,
                    height: 6,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.secondary,
                    ),
                  ),
                  const SizedBox(width: 5),
                  Text(
                    '${departmentsCount > 0 ? departmentsCount : 8} Departments',
                    style: AppTypography.labelSm.copyWith(
                      color: AppColors.onSurfaceVariant,
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            'Atelier Collections',
            style: AppTypography.headlineSm.copyWith(
              fontSize: 24,
              fontWeight: FontWeight.w800,
              color: const Color(0xFF002419),
              letterSpacing: -0.5,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            'Explore handcrafted rarity across master categories & private reserves.',
            style: AppTypography.bodySm.copyWith(
              color: AppColors.onSurfaceVariant,
              fontSize: 12.5,
              height: 1.35,
            ),
          ),
        ],
      ),
    );
  }
}
