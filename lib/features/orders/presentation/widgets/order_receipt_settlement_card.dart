import 'package:aura/core/theme/app_colors.dart';
import 'package:aura/core/theme/app_typography.dart';
import 'package:aura/features/orders/domain/entities/order_entity.dart';
import 'package:aura/features/orders/presentation/utils/order_ui_helper.dart';
import 'package:flutter/material.dart';

class OrderReceiptSettlementCard extends StatelessWidget {
  final OrderEntity order;

  const OrderReceiptSettlementCard({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    final formattedTotal = OrderUiHelper.formatPriceDecimal(order.totalAmount);

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
          Text(
            'SETTLEMENT SUMMARY',
            style: AppTypography.labelCaps.copyWith(
              color: const Color(0xFF0B3B2C),
              fontWeight: FontWeight.w800,
              fontSize: 10.5,
              letterSpacing: 1.1,
            ),
          ),
          const SizedBox(height: 12),
          _SummaryLine(
            label: 'Items Subtotal',
            value: formattedTotal,
          ),
          const SizedBox(height: 6),
          const _SummaryLine(
            label: 'Delivery Protocol',
            value: 'FREE',
            valueColor: Color(0xFF006C49),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 8),
            child: Divider(color: Color(0xFFF1F5F9)),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Total Amount',
                style: AppTypography.headlineSm.copyWith(
                  fontSize: 15,
                  fontWeight: FontWeight.w800,
                  color: const Color(0xFF002419),
                ),
              ),
              Text(
                formattedTotal,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w900,
                  color: Color(0xFF0B3B2C),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _SummaryLine extends StatelessWidget {
  final String label;
  final String value;
  final Color? valueColor;

  const _SummaryLine({
    required this.label,
    required this.value,
    this.valueColor,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 12.5, color: AppColors.slateBody),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: 12.5,
            fontWeight: FontWeight.w700,
            color: valueColor ?? const Color(0xFF1E293B),
          ),
        ),
      ],
    );
  }
}
