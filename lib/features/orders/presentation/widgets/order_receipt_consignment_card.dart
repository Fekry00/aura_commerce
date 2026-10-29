import 'package:aura/core/theme/app_colors.dart';
import 'package:aura/core/theme/app_typography.dart';
import 'package:aura/features/orders/domain/entities/order_entity.dart';
import 'package:flutter/material.dart';

class OrderReceiptConsignmentCard extends StatelessWidget {
  final OrderEntity order;

  const OrderReceiptConsignmentCard({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(AppSpacing.spaceMd),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      padding: const EdgeInsets.all(AppSpacing.spaceMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(
                Icons.location_on_outlined,
                size: 18,
                color: Color(0xFF0B3B2C),
              ),
              const SizedBox(width: AppSpacing.spaceSm),
              Text(
                'DELIVERY ADDRESS & CONTACT',
                style: AppTypography.labelCaps.copyWith(
                  color: const Color(0xFF0B3B2C),
                  fontWeight: FontWeight.w800,
                  letterSpacing: 1.1,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.space12),
          Text(
            order.shippingAddress,
            style: AppTypography.bodyMd.copyWith(
              fontWeight: FontWeight.w600,
              color: const Color(0xFF1E293B),
            ),
          ),
          if (order.phone != null && order.phone!.isNotEmpty) ...[
            const SizedBox(height: AppSpacing.spaceXs),
            Row(
              children: [
                const Icon(Icons.phone, size: 14, color: AppColors.slateBody),
                const SizedBox(width: AppSpacing.spaceSm),
                Text(
                  order.phone!,
                  style: AppTypography.bodySm.copyWith(
                    color: AppColors.slateBody,
                  ),
                ),
              ],
            ),
          ],
          if (order.notes != null && order.notes!.isNotEmpty) ...[
            const SizedBox(height: AppSpacing.spaceSm),
            Text(
              'Notes: ${order.notes}',
              style: AppTypography.labelCaps.copyWith(
                fontStyle: FontStyle.italic,
                color: AppColors.slateBody,
              ),
            ),
          ],
          const SizedBox(height: AppSpacing.spaceSm),
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.spaceSm,
              vertical: AppSpacing.spaceXs,
            ),
            decoration: BoxDecoration(
              color: const Color(0xFFF1F5F9),
              borderRadius: BorderRadius.circular(AppSpacing.spaceXs),
            ),
            child: Text(
              'Payment: ${order.paymentMethod.toUpperCase()}',
              style: AppTypography.labelCaps.copyWith(
                fontWeight: FontWeight.w700,
                color: const Color(0xFF475569),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
