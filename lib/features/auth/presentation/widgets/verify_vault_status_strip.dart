import 'package:aura/core/theme/app_colors.dart';
import 'package:aura/core/theme/app_typography.dart';
import 'package:flutter/material.dart';

class VerifyVaultStatusStrip extends StatelessWidget {
  final VoidCallback? onConciergeTap;

  const VerifyVaultStatusStrip({super.key, this.onConciergeTap});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.spaceSm + 2, vertical: AppSpacing.spaceXs),
          decoration: BoxDecoration(color: AppColors.surfaceContainerLow, borderRadius: BorderRadius.circular(AppSpacing.spaceLg)),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(width: 6, height: 6, decoration: const BoxDecoration(color: AppColors.secondary, shape: BoxShape.circle)),
              const SizedBox(width: AppSpacing.spaceXs + 2),
              Text('ATELIER VAULT PROTECTED', style: AppTypography.labelCaps.copyWith(color: AppColors.onSurfaceVariant, fontSize: 10)),
            ],
          ),
        ),
        GestureDetector(
          onTap: onConciergeTap,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.spaceSm + 2, vertical: AppSpacing.spaceXs),
            decoration: BoxDecoration(
              color: AppColors.surfaceContainerLowest,
              borderRadius: BorderRadius.circular(AppSpacing.spaceLg),
              border: Border.all(color: AppColors.outlineVariant),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.support_agent_rounded, size: 16, color: AppColors.secondary),
                const SizedBox(width: AppSpacing.spaceXs),
                Text('Concierge', style: AppTypography.labelSm.copyWith(color: AppColors.primary, fontWeight: FontWeight.w600)),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
