import 'package:aura/core/theme/app_colors.dart';
import 'package:aura/core/theme/app_typography.dart';
import 'package:aura/features/orders/presentation/widgets/order_summary_line_row.dart';
import 'package:flutter/material.dart';

class OrderSettlementSummaryCard extends StatelessWidget {
  const OrderSettlementSummaryCard({super.key});

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
        children: [
          Padding(
            padding: const EdgeInsets.all(AppSpacing.spaceMd),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'SETTLEMENT SUMMARY',
                      style: AppTypography.labelCaps.copyWith(
                        color: AppColors.slateBody,
                        fontSize: 10,
                        letterSpacing: 0.9,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Row(
                      children: [
                        const Icon(
                          Icons.verified_outlined,
                          size: 13,
                          color: AppColors.secondary,
                        ),
                        const SizedBox(width: 3),
                        Text(
                          'Escrow Confirmed',
                          style: AppTypography.labelCaps.copyWith(
                            color: AppColors.secondary,
                            fontWeight: FontWeight.w700,
                            fontSize: 9.5,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: AppSpacing.spaceMd),
                const OrderSummaryLineRow(
                  label: 'Subtotal (3 items)',
                  value: '\$2,660.00',
                ),
                const SizedBox(height: AppSpacing.spaceSm + 2),
                const OrderSummaryLineRow(
                  label: 'VIP Privilege (WELCOME10 - 10%)',
                  value: '-\$266.00',
                  valueColor: AppColors.secondary,
                ),
                const SizedBox(height: AppSpacing.spaceSm + 2),
                const OrderSummaryLineRow(
                  label: 'Armored Courier Transit',
                  value: '\$0.00',
                  badgeText: 'VIP COMPLIMENTARY',
                  icon: Icons.shield_outlined,
                ),
                const SizedBox(height: AppSpacing.spaceSm + 2),
                const OrderSummaryLineRow(
                  label: 'Duties & Atelier Handling',
                  value: '\$191.50',
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(AppSpacing.spaceMd),
            decoration: BoxDecoration(
              color: AppColors.primary.withValues(alpha: 0.03),
              borderRadius: const BorderRadius.vertical(
                bottom: Radius.circular(AppSpacing.spaceMd),
              ),
              border: Border(
                top: BorderSide(
                  color: AppColors.outlineVariant.withValues(alpha: 0.4),
                ),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Total Amount Paid',
                      style: AppTypography.headlineSm.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      'Amex Centurion •••• 1008',
                      style: AppTypography.bodySm.copyWith(
                        color: AppColors.slateBody,
                        fontSize: 11,
                      ),
                    ),
                  ],
                ),
                Text(
                  '\$2,585.50',
                  style: AppTypography.priceHero.copyWith(
                    fontWeight: FontWeight.w800,
                    fontSize: 22,
                    color: AppColors.primaryContainer,
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
