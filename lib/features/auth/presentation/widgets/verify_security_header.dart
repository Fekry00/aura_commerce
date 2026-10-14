import 'package:aura/core/theme/app_colors.dart';
import 'package:aura/core/theme/app_typography.dart';
import 'package:flutter/material.dart';

class VerifySecurityHeader extends StatelessWidget {
  final String email;
  final VoidCallback? onChangeEmail;

  const VerifySecurityHeader({super.key, this.email = 'claire.d***@atelier.com', this.onChangeEmail});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildGlowingLock(),
        const SizedBox(height: AppSpacing.spaceMd),
        Text(
          'Two-Factor Security',
          style: AppTypography.headlineLg.copyWith(color: AppColors.primary, fontWeight: FontWeight.w700),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: AppSpacing.spaceXs),
        Text.rich(
          TextSpan(
            text: "We've dispatched a 6-digit confidential authorization code to\n",
            style: AppTypography.bodySm.copyWith(color: AppColors.onSurfaceVariant),
            children: [
              TextSpan(
                text: email,
                style: AppTypography.bodySm.copyWith(fontWeight: FontWeight.w700, color: AppColors.onSurface),
              ),
            ],
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: AppSpacing.spaceSm),
        GestureDetector(
          onTap: onChangeEmail,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'WRONG EMAIL? CHANGE',
                style: AppTypography.labelCaps.copyWith(color: AppColors.secondary, fontWeight: FontWeight.w700),
              ),
              const SizedBox(width: AppSpacing.spaceXs),
              const Icon(Icons.arrow_forward_rounded, size: 13, color: AppColors.secondary),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildGlowingLock() {
    return Stack(
      alignment: Alignment.center,
      clipBehavior: Clip.none,
      children: [
        Container(
          width: 90,
          height: 90,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.secondaryContainer.withValues(alpha: 0.25),
            boxShadow: [
              BoxShadow(color: AppColors.secondaryContainer.withValues(alpha: 0.4), blurRadius: 28, spreadRadius: 6),
            ],
          ),
        ),
        Container(
          width: 80,
          height: 80,
          padding: const EdgeInsets.all(AppSpacing.spaceXs),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.surfaceContainerLowest,
            border: Border.all(color: AppColors.secondaryContainer.withValues(alpha: 0.6), width: 2),
          ),
          child: Container(
            decoration: const BoxDecoration(shape: BoxShape.circle, color: AppColors.primary),
            child: const Icon(Icons.lock_rounded, color: AppColors.secondaryContainer, size: 32),
          ),
        ),
        Positioned(
          top: 0,
          right: AppSpacing.spaceXs,
          child: Container(
            width: 10,
            height: 10,
            decoration: const BoxDecoration(shape: BoxShape.circle, color: AppColors.secondaryContainer),
          ),
        ),
      ],
    );
  }
}
