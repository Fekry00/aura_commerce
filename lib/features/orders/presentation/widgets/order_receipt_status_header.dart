import 'package:aura/core/theme/app_colors.dart';
import 'package:aura/core/theme/app_typography.dart';
import 'package:aura/features/orders/domain/entities/order_entity.dart';
import 'package:aura/features/orders/presentation/utils/order_ui_helper.dart';
import 'package:flutter/material.dart';

class OrderReceiptStatusHeader extends StatelessWidget {
  final OrderEntity order;

  const OrderReceiptStatusHeader({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    final statusColor = OrderUiHelper.getStatusColor(order.status);
    final statusBg = OrderUiHelper.getStatusBgColor(order.status);

    return Container(
      padding: const EdgeInsets.all(AppSpacing.margin),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(AppSpacing.margin),
        border: Border.all(color: const Color(0xFFE2E8F0)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: const Color(0xFF0B3B2C).withValues(alpha: 0.1),
            ),
            child: const Icon(
              Icons.check_circle_rounded,
              color: Color(0xFF0B3B2C),
              size: AppSpacing.space32,
            ),
          ),
          const SizedBox(height: AppSpacing.space12),
          Text(
            'Order Confirmed',
            style: AppTypography.headlineSm.copyWith(
              fontWeight: FontWeight.w800,
              color: const Color(0xFF002419),
            ),
          ),
          const SizedBox(height: AppSpacing.spaceXs),
          Text(
            OrderUiHelper.formatOrderId(order.id),
            style: AppTypography.bodySm.copyWith(
              fontWeight: FontWeight.w700,
              color: AppColors.slateBody,
              letterSpacing: 1.1,
            ),
          ),
          const SizedBox(height: AppSpacing.space12),
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.space12,
              vertical: AppSpacing.spaceXs,
            ),
            decoration: BoxDecoration(
              color: statusBg,
              borderRadius: BorderRadius.circular(AppSpacing.margin),
            ),
            child: Text(
              order.status.toUpperCase(),
              style: AppTypography.labelCaps.copyWith(
                color: statusColor,
                fontWeight: FontWeight.w800,
                letterSpacing: 1.2,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
