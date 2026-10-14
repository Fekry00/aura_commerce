import 'package:aura/core/theme/app_colors.dart';
import 'package:aura/core/theme/app_typography.dart';
import 'package:flutter/material.dart';

class VerifyKeycodeHeaderRow extends StatelessWidget {
  final String formattedTimer;

  const VerifyKeycodeHeaderRow({super.key, required this.formattedTimer});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'CONFIDENTIAL KEYCODE',
          style: AppTypography.labelCaps.copyWith(color: AppColors.onSurfaceVariant, letterSpacing: 0.8),
        ),
        Row(
          children: [
            const Icon(Icons.timer_outlined, size: 14, color: AppColors.secondary),
            const SizedBox(width: AppSpacing.spaceXs),
            Text(
              formattedTimer,
              style: AppTypography.labelSm.copyWith(color: AppColors.secondary, fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ],
    );
  }
}
