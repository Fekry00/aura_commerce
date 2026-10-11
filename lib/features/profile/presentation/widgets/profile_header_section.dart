import 'package:aura/core/theme/app_colors.dart';
import 'package:aura/core/theme/app_typography.dart';
import 'package:flutter/material.dart';

class ProfileHeaderSection extends StatelessWidget {
  const ProfileHeaderSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.margin,
        vertical: AppSpacing.spaceSm,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'SANCTUARY',
                  style: AppTypography.labelCaps.copyWith(
                    color: AppColors.secondary,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 1.5,
                  ),
                ),
                const SizedBox(height: AppSpacing.spaceXs),
                Text(
                  'My Atelier',
                  style: AppTypography.headlineLg.copyWith(
                    fontWeight: FontWeight.w800,
                    color: AppColors.slateHeadline,
                  ),
                ),
              ],
            ),
          ),
          Row(
            children: [
              _buildHeaderActionButton(
                icon: Icons.qr_code_scanner_rounded,
                onTap: () {},
              ),
              const SizedBox(width: AppSpacing.spaceSm),
              _buildHeaderActionButton(
                icon: Icons.support_agent_rounded,
                onTap: () {},
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildHeaderActionButton({
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppSpacing.margin),
      child: Container(
        width: AppSpacing.spaceXl,
        height: AppSpacing.spaceXl,
        decoration: BoxDecoration(
          color: AppColors.surfaceContainerLowest,
          shape: BoxShape.circle,
          border: Border.all(
            color: AppColors.outlineVariant,
            width: 1.0,
          ),
        ),
        child: Icon(
          icon,
          size: AppSpacing.spaceMd + 2,
          color: AppColors.slateHeadline,
        ),
      ),
    );
  }
}
