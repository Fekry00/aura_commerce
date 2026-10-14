import 'package:aura/core/theme/app_colors.dart';
import 'package:aura/core/theme/app_typography.dart';
import 'package:flutter/material.dart';

class OrderConciergeProtocolNote extends StatelessWidget {
  const OrderConciergeProtocolNote({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.spaceSm + 2),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerLow,
        borderRadius: BorderRadius.circular(AppSpacing.spaceSm),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(
            Icons.shield_outlined,
            size: 16,
            color: AppColors.secondary,
          ),
          const SizedBox(width: AppSpacing.spaceSm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Concierge Delivery Protocol',
                  style: AppTypography.bodySm.copyWith(
                    color: AppColors.slateHeadline,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  '“Leave with private concierge upon arrival”',
                  style: AppTypography.bodySm.copyWith(
                    color: AppColors.slateBody,
                    fontStyle: FontStyle.italic,
                    fontSize: 11.5,
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
