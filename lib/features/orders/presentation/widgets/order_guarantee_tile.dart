import 'package:aura/core/theme/app_colors.dart';
import 'package:aura/core/theme/app_typography.dart';
import 'package:flutter/material.dart';

class OrderGuaranteeTile extends StatelessWidget {
  final IconData icon;
  final String label;

  const OrderGuaranteeTile({
    super.key,
    required this.icon,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 18, color: AppColors.secondary),
        const SizedBox(width: AppSpacing.spaceSm),
        Flexible(
          child: Text(
            label,
            style: AppTypography.bodySm.copyWith(
              color: AppColors.slateBody,
              height: 1.35,
              fontSize: 11.5,
            ),
          ),
        ),
      ],
    );
  }
}
