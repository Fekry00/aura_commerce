import 'package:aura/core/theme/app_colors.dart';
import 'package:aura/core/theme/app_typography.dart';
import 'package:flutter/material.dart';

class ProfileFooter extends StatelessWidget {
  const ProfileFooter({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.spaceMd),
      child: Column(
        children: [
          Text(
            'AURA LUXE ATELIER IOS V4.2.0 (BUILD 882)',
            style: AppTypography.labelCaps.copyWith(
              color: AppColors.slateBody,
              letterSpacing: 0.8,
              fontSize: 10,
            ),
          ),
          const SizedBox(height: AppSpacing.spaceXs),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.lock_outline_rounded,
                size: AppSpacing.spaceSm + AppSpacing.spaceXs / 2,
                color: AppColors.slateBody,
              ),
              const SizedBox(width: AppSpacing.spaceXs),
              Text(
                '256-Bit Cryptographic Vault Active',
                style: AppTypography.bodySm.copyWith(
                  color: AppColors.slateBody,
                  fontSize: 10,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
