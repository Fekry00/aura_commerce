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
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      padding: const EdgeInsets.all(16),
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
              const SizedBox(width: 8),
              Text(
                'DELIVERY ADDRESS & CONTACT',
                style: AppTypography.labelCaps.copyWith(
                  color: const Color(0xFF0B3B2C),
                  fontWeight: FontWeight.w800,
                  fontSize: 10.5,
                  letterSpacing: 1.1,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            order.shippingAddress,
            style: const TextStyle(
              fontSize: 13.5,
              fontWeight: FontWeight.w600,
              color: Color(0xFF1E293B),
            ),
          ),
          if (order.phone != null && order.phone!.isNotEmpty) ...[
            const SizedBox(height: 4),
            Row(
              children: [
                const Icon(Icons.phone, size: 14, color: AppColors.slateBody),
                const SizedBox(width: 6),
                Text(
                  order.phone!,
                  style: const TextStyle(
                    fontSize: 12,
                    color: AppColors.slateBody,
                  ),
                ),
              ],
            ),
          ],
          if (order.notes != null && order.notes!.isNotEmpty) ...[
            const SizedBox(height: 6),
            Text(
              'Notes: ${order.notes}',
              style: const TextStyle(
                fontSize: 11.5,
                fontStyle: FontStyle.italic,
                color: AppColors.slateBody,
              ),
            ),
          ],
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: const Color(0xFFF1F5F9),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text(
              'Payment: ${order.paymentMethod.toUpperCase()}',
              style: const TextStyle(
                fontSize: 10.5,
                fontWeight: FontWeight.w700,
                color: Color(0xFF475569),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
