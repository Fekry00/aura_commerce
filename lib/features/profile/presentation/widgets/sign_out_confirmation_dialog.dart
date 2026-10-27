import 'package:aura/core/theme/app_colors.dart';
import 'package:aura/core/theme/app_typography.dart';
import 'package:flutter/material.dart';

/// Pure declarative UI confirmation dialog for signing out of Atelier session.
class SignOutConfirmationDialog extends StatelessWidget {
  final VoidCallback? onConfirm;

  const SignOutConfirmationDialog({super.key, this.onConfirm});

  /// Static helper to display the confirmation dialog.
  static Future<bool?> show(
    BuildContext context, {
    VoidCallback? onConfirm,
  }) {
    return showDialog<bool>(
      context: context,
      barrierDismissible: true,
      builder: (dialogContext) => SignOutConfirmationDialog(
        onConfirm: onConfirm,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSpacing.margin),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: Container(
        padding: const EdgeInsets.all(AppSpacing.margin),
        decoration: BoxDecoration(
          color: AppColors.surfaceContainerLowest,
          borderRadius: BorderRadius.circular(AppSpacing.margin),
          border: Border.all(
            color: AppColors.outlineVariant.withValues(alpha: 0.6),
            width: 1.0,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.08),
              blurRadius: 24,
              offset: const Offset(0, 12),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(AppSpacing.spaceSm + AppSpacing.spaceXs),
              decoration: BoxDecoration(
                color: AppColors.error.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.logout_rounded,
                size: 28,
                color: AppColors.error,
              ),
            ),
            const SizedBox(height: AppSpacing.spaceMd),
            Text(
              'Sign Out of Atelier',
              style: AppTypography.headlineSm.copyWith(
                color: AppColors.slateHeadline,
                fontWeight: FontWeight.w700,
                fontSize: 18,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppSpacing.spaceXs),
            Text(
              'Are you sure you want to log out of your session? You will need to sign in again to access your private salon & curated vault.',
              style: AppTypography.bodySm.copyWith(
                color: AppColors.slateBody,
                fontSize: 13,
                height: 1.45,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppSpacing.spaceLg),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      side: const BorderSide(color: AppColors.outlineVariant),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: () => Navigator.pop(context, false),
                    child: Text(
                      'Cancel',
                      style: AppTypography.bodySm.copyWith(
                        color: AppColors.slateBody,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: AppSpacing.spaceSm),
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.error,
                      elevation: 0,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: () {
                      Navigator.pop(context, true);
                      onConfirm?.call();
                    },
                    child: Text(
                      'Sign Out',
                      style: AppTypography.bodySm.copyWith(
                        color: AppColors.onError,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
