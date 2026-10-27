import 'package:aura/core/theme/app_colors.dart';
import 'package:aura/core/theme/app_typography.dart';
import 'package:flutter/material.dart';

/// Pure declarative UI button for signing out of Atelier.
class ProfileSignOutButton extends StatelessWidget {
  final VoidCallback? onTap;

  const ProfileSignOutButton({super.key, this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppSpacing.margin),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: AppSpacing.spaceMd - 2),
        decoration: BoxDecoration(
          color: AppColors.surfaceContainerLowest,
          borderRadius: BorderRadius.circular(AppSpacing.margin),
          border: Border.all(
            color: AppColors.error.withValues(alpha: 0.25),
            width: 1.0,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.logout_rounded,
              size: AppSpacing.spaceMd + 2,
              color: AppColors.error,
            ),
            const SizedBox(width: AppSpacing.spaceSm),
            Text(
              'Sign Out of Atelier',
              style: AppTypography.bodyMd.copyWith(
                color: AppColors.error,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
