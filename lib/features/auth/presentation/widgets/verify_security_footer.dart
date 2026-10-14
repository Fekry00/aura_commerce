import 'package:aura/core/theme/app_colors.dart';
import 'package:aura/core/theme/app_typography.dart';
import 'package:flutter/material.dart';

class VerifySecurityFooter extends StatelessWidget {
  final VoidCallback? onLockAccount;

  const VerifySecurityFooter({super.key, this.onLockAccount});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.verified_user_outlined, size: 16, color: AppColors.secondary),
            const SizedBox(width: AppSpacing.spaceSm),
            Text(
              'ENCRYPTED END-TO-END VIA ATELIER VAULT',
              style: AppTypography.labelCaps.copyWith(
                color: AppColors.onSurfaceVariant,
                letterSpacing: 1.0,
              ),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.spaceSm + 2),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.gutter),
          child: GestureDetector(
            onTap: onLockAccount,
            child: Text.rich(
              TextSpan(
                text: 'Did not initiate this reset request? Protect your luxury assets and ',
                style: AppTypography.bodySm.copyWith(color: AppColors.onSurfaceVariant),
                children: [
                  TextSpan(
                    text: 'tap here to lock your account immediately',
                    style: AppTypography.bodySm.copyWith(
                      color: AppColors.error,
                      fontWeight: FontWeight.w600,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                  const WidgetSpan(
                    alignment: PlaceholderAlignment.middle,
                    child: Padding(
                      padding: EdgeInsets.only(left: 3),
                      child: Icon(Icons.lock_person_outlined, size: 13, color: AppColors.error),
                    ),
                  ),
                  const TextSpan(text: '.'),
                ],
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ],
    );
  }
}
