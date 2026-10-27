import 'package:aura/core/theme/app_colors.dart';
import 'package:aura/core/theme/app_typography.dart';
import 'package:flutter/material.dart';

class CategoriesGuaranteeSection extends StatelessWidget {
  const CategoriesGuaranteeSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 14,
              vertical: 6,
            ),
            decoration: BoxDecoration(
              color: AppColors.surfaceContainerLow,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.verified_user_outlined,
                  size: 15,
                  color: AppColors.secondary,
                ),
                const SizedBox(width: 6),
                Text(
                  'ATELIER AUTHENTICITY ESCROW GUARANTEE',
                  style: AppTypography.labelSm.copyWith(
                    fontSize: 9,
                    fontWeight: FontWeight.w700,
                    color: AppColors.onSurfaceVariant,
                    letterSpacing: 0.5,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Every vault acquisition includes dual horological appraisal and cryptographic ledger provenance.',
            textAlign: TextAlign.center,
            style: AppTypography.bodySm.copyWith(
              color: AppColors.onSurfaceVariant,
              fontSize: 12,
              height: 1.5,
            ),
          ),
          const SizedBox(height: 40),
        ],
      ),
    );
  }
}
