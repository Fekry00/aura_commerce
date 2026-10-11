import 'package:aura/core/theme/app_colors.dart';
import 'package:aura/core/theme/app_typography.dart';
import 'package:flutter/material.dart';

class EditProfileFooter extends StatelessWidget {
  const EditProfileFooter({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.spaceMd),
      child: Column(
        children: [
          Text(
            'AURA HAUTE PARFUMERIE & LIFESTYLE',
            style: AppTypography.labelCaps.copyWith(
              color: AppColors.outline,
              letterSpacing: 1.2,
              fontSize: 10,
            ),
          ),
          const SizedBox(height: AppSpacing.spaceXs / 2),
          Text(
            'End-to-End Cryptographic Escrow',
            style: AppTypography.bodySm.copyWith(
              color: AppColors.outline,
              fontSize: 11,
            ),
          ),
        ],
      ),
    );
  }
}
