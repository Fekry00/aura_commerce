import 'package:aura/core/theme/app_colors.dart';
import 'package:aura/core/theme/app_typography.dart';
import 'package:aura/features/orders/presentation/widgets/order_concierge_protocol_note.dart';
import 'package:flutter/material.dart';

class OrderConsignmentAddressCard extends StatelessWidget {
  const OrderConsignmentAddressCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(AppSpacing.spaceMd),
        border: Border.all(
          color: AppColors.outlineVariant.withValues(alpha: 0.5),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(AppSpacing.spaceMd),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Icon(
                      Icons.location_on_outlined,
                      size: 18,
                      color: AppColors.primaryContainer,
                    ),
                    const SizedBox(width: AppSpacing.spaceXs + 2),
                    Text(
                      'CONSIGNMENT ADDRESS',
                      style: AppTypography.labelCaps.copyWith(
                        color: AppColors.slateBody,
                        fontSize: 10,
                        letterSpacing: 0.9,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.spaceSm,
                    vertical: 3,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.surfaceContainerLow,
                    borderRadius: BorderRadius.circular(AppSpacing.margin),
                  ),
                  child: Text(
                    'Default: Residence',
                    style: AppTypography.labelCaps.copyWith(
                      color: AppColors.onSurfaceVariant,
                      fontSize: 9.5,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Divider(
            height: 1,
            color: AppColors.outlineVariant.withValues(alpha: 0.4),
          ),
          Padding(
            padding: const EdgeInsets.all(AppSpacing.spaceMd),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Ahmed Mohamed',
                  style: AppTypography.bodyMd.copyWith(
                    fontWeight: FontWeight.w700,
                    color: AppColors.slateHeadline,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  '+20 100 000 0000',
                  style: AppTypography.bodySm.copyWith(
                    color: AppColors.slateBody,
                  ),
                ),
                const SizedBox(height: AppSpacing.spaceXs),
                Text(
                  '123 Main St, Gihan, Mansoura\nDakahlia Governorate, Egypt',
                  style: AppTypography.bodySm.copyWith(
                    color: AppColors.slateBody,
                    height: 1.45,
                  ),
                ),
                const SizedBox(height: AppSpacing.spaceMd),
                const OrderConciergeProtocolNote(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
