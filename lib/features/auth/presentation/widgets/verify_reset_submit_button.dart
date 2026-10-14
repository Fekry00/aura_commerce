import 'package:aura/core/theme/app_colors.dart';
import 'package:aura/core/theme/app_typography.dart';
import 'package:flutter/material.dart';

class VerifyResetSubmitButton extends StatelessWidget {
  final VoidCallback? onPressed;

  const VerifyResetSubmitButton({super.key, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 48,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
          elevation: 0,
        ),
        onPressed: onPressed,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Verify & Reset Password',
              style: AppTypography.bodyMd.copyWith(color: AppColors.onPrimary, fontWeight: FontWeight.w700),
            ),
            const SizedBox(width: AppSpacing.spaceSm),
            const Icon(Icons.arrow_forward_rounded, color: AppColors.onPrimary, size: 18),
          ],
        ),
      ),
    );
  }
}
