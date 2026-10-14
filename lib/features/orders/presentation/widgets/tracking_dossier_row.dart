import 'package:aura/core/theme/app_colors.dart';
import 'package:aura/core/theme/app_typography.dart';
import 'package:flutter/material.dart';

class TrackingDossierRow extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final Color? subtitleColor;
  final String? badgeText;

  const TrackingDossierRow({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    this.subtitleColor,
    this.badgeText,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 34,
          height: 34,
          decoration: BoxDecoration(
            color: AppColors.surfaceContainerLow,
            shape: BoxShape.circle,
          ),
          child: Icon(icon, size: 16, color: AppColors.primaryContainer),
        ),
        const SizedBox(width: AppSpacing.spaceSm + 2),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    title,
                    style: AppTypography.bodyMd.copyWith(
                      fontWeight: FontWeight.w700,
                      color: AppColors.slateHeadline,
                    ),
                  ),
                  if (badgeText != null)
                    Text(
                      badgeText!,
                      style: AppTypography.labelCaps.copyWith(
                        color: AppColors.secondary,
                        fontWeight: FontWeight.w800,
                        fontSize: 9.5,
                      ),
                    ),
                ],
              ),
              const SizedBox(height: 2),
              Text(
                subtitle,
                style: AppTypography.bodySm.copyWith(
                  color: subtitleColor ?? AppColors.slateBody,
                  fontSize: 11,
                  height: 1.35,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
