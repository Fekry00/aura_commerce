import 'package:aura/core/theme/app_colors.dart';
import 'package:aura/core/theme/app_typography.dart';
import 'package:aura/features/profile/presentation/widgets/delete_account_bottom_sheet.dart';
import 'package:flutter/material.dart';

class EditProfileDangerZoneSection extends StatelessWidget {
  final Future<void> Function(String password)? onConfirmDelete;

  const EditProfileDangerZoneSection({super.key, this.onConfirmDelete});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.margin),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(AppSpacing.margin),
        border: Border.all(color: AppColors.outlineVariant, width: 1.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.warning_amber_rounded, size: AppSpacing.spaceMd, color: AppColors.error),
              const SizedBox(width: AppSpacing.spaceXs),
              Text('PERMANENT REVOCATION', style: AppTypography.labelCaps.copyWith(color: AppColors.error, letterSpacing: 1.2)),
            ],
          ),
          const SizedBox(height: AppSpacing.spaceXs / 2),
          Text(
            'Account Deactivation & Vault Purge',
            style: AppTypography.headlineSm.copyWith(color: AppColors.error, fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: AppSpacing.spaceMd),
          Container(
            padding: const EdgeInsets.all(AppSpacing.spaceSm + AppSpacing.spaceXs),
            decoration: BoxDecoration(
              color: AppColors.error.withValues(alpha: 0.08),
              borderRadius: BorderRadius.circular(AppSpacing.spaceSm),
            ),
            child: Text(
              'Requesting deactivation will irreversibly purge your historical order ledgers, VIP concierge transcripts, saved perfume preferences, and confidential address vault.',
              style: AppTypography.bodySm.copyWith(color: AppColors.onSurfaceVariant, height: 1.5),
            ),
          ),
          const SizedBox(height: AppSpacing.spaceMd),
          InkWell(
            onTap: () => DeleteAccountBottomSheet.show(context, onConfirmDelete: onConfirmDelete),
            borderRadius: BorderRadius.circular(AppSpacing.margin),
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: AppSpacing.spaceMd - 2),
              decoration: BoxDecoration(
                color: AppColors.error.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(AppSpacing.margin),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.delete_forever_rounded, size: AppSpacing.spaceMd + 2, color: AppColors.error),
                  const SizedBox(width: AppSpacing.spaceSm),
                  Text(
                    'Delete Account',
                    style: AppTypography.bodyMd.copyWith(color: AppColors.error, fontWeight: FontWeight.w700),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
