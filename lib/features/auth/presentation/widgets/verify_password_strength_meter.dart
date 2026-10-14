import 'package:aura/core/theme/app_colors.dart';
import 'package:aura/core/theme/app_typography.dart';
import 'package:flutter/material.dart';

class VerifyPasswordStrengthMeter extends StatelessWidget {
  final int score;
  final String label;

  const VerifyPasswordStrengthMeter({super.key, required this.score, required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        for (int i = 1; i <= 4; i++) ...[
          Expanded(
            child: Container(
              height: 4,
              decoration: BoxDecoration(
                color: i <= score ? AppColors.secondary : AppColors.surfaceContainer,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          if (i < 4) const SizedBox(width: AppSpacing.spaceXs),
        ],
        const SizedBox(width: AppSpacing.spaceSm),
        Text(
          label,
          style: AppTypography.labelCaps.copyWith(color: AppColors.secondary, fontWeight: FontWeight.w700),
        ),
      ],
    );
  }
}
