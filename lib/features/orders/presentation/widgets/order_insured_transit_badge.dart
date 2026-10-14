import 'package:aura/core/theme/app_colors.dart';
import 'package:aura/core/theme/app_typography.dart';
import 'package:flutter/material.dart';

class OrderInsuredTransitBadge extends StatelessWidget {
  const OrderInsuredTransitBadge({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Icon(Icons.shield_outlined, size: 13, color: AppColors.secondary),
        const SizedBox(width: AppSpacing.spaceXs),
        Text(
          'Insured Transit',
          style: AppTypography.labelCaps.copyWith(
            color: AppColors.secondary,
            fontWeight: FontWeight.w700,
            fontSize: 10,
          ),
        ),
      ],
    );
  }
}
