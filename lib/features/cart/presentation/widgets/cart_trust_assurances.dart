import 'package:aura/core/theme/app_colors.dart';
import 'package:aura/core/theme/app_typography.dart';
import 'package:flutter/material.dart';

class CartTrustAssurances extends StatelessWidget {
  const CartTrustAssurances({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _buildAssuranceCard(
            icon: Icons.lock_outline_rounded,
            title: '256-Bit SSL',
            subtitle: 'Bank-Grade Security',
          ),
        ),
        const SizedBox(width: AppSpacing.spaceSm + AppSpacing.spaceXs),
        Expanded(
          child: _buildAssuranceCard(
            icon: Icons.published_with_changes_rounded,
            title: '30-Day Returns',
            subtitle: 'Doorstep Courier Pickup',
          ),
        ),
      ],
    );
  }

  Widget _buildAssuranceCard({
    required IconData icon,
    required String title,
    required String subtitle,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.spaceMd - 2,
        vertical: AppSpacing.spaceMd - 2,
      ),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerLow,
        borderRadius: BorderRadius.circular(
          AppSpacing.spaceSm + AppSpacing.spaceXs + 2,
        ),
      ),
      child: Row(
        children: [
          Icon(
            icon,
            size: AppSpacing.spaceLg - 2,
            color: AppColors.secondary,
          ),
          const SizedBox(width: AppSpacing.spaceSm + 2),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  title,
                  style: AppTypography.labelCaps.copyWith(
                    fontWeight: FontWeight.w700,
                    color: AppColors.onSurface,
                  ),
                ),
                const SizedBox(height: AppSpacing.spaceXs / 2),
                Text(
                  subtitle,
                  style: AppTypography.bodySm.copyWith(
                    color: AppColors.onSurfaceVariant,
                    fontSize: 10.5,
                    height: 1.2,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
