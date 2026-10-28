import 'package:aura/core/theme/app_colors.dart';
import 'package:aura/core/theme/app_typography.dart';
import 'package:aura/features/orders/domain/entities/order_entity.dart';
import 'package:flutter/material.dart';

class TrackingHeaderStatus extends StatelessWidget {
  final OrderEntity? order;
  final String? orderId;
  final String? totalAmount;
  final String? etaTime;

  const TrackingHeaderStatus({
    super.key,
    this.order,
    this.orderId,
    this.totalAmount,
    this.etaTime,
  });

  @override
  Widget build(BuildContext context) {
    final displayOrderId = order != null ? 'Order #AUR-${order!.id}' : (orderId ?? 'Order #AL-984218');
    final displayTotal = order != null ? '\$${order!.totalAmount.toStringAsFixed(2)}' : (totalAmount ?? '\$2,585.50');
    final displayEta = etaTime ??
        (order?.isDelivered == true
            ? 'Delivered to Destination'
            : (order?.isShipped == true
                ? 'Today, Estimated arrival 2:45 PM – 3:15 PM'
                : 'Processing • Estimated dispatch today'));
    final statusBadge = order?.status.toUpperCase() ?? 'OUT FOR WHITE-GLOVE COURIER';
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'DISPATCH LOGISTICS',
              style: AppTypography.labelCaps.copyWith(
                color: AppColors.slateBody,
                fontSize: 10,
                letterSpacing: 1.0,
                fontWeight: FontWeight.w700,
              ),
            ),
            Text(
              'Priority Tier I',
              style: AppTypography.labelSm.copyWith(
                color: AppColors.secondary,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.spaceXs),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              displayOrderId,
              style: AppTypography.headlineMd.copyWith(
                fontWeight: FontWeight.w700,
                color: AppColors.slateHeadline,
              ),
            ),
            Text(
              displayTotal,
              style: AppTypography.headlineSm.copyWith(
                fontWeight: FontWeight.w700,
                color: AppColors.slateHeadline,
              ),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.spaceSm),
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.spaceSm + 2,
            vertical: AppSpacing.spaceXs,
          ),
          decoration: BoxDecoration(
            color: AppColors.secondaryContainer.withValues(alpha: 0.4),
            borderRadius: BorderRadius.circular(AppSpacing.margin),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 7,
                height: 7,
                decoration: const BoxDecoration(
                  color: AppColors.secondary,
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 6),
              Text(
                statusBadge,
                style: AppTypography.labelCaps.copyWith(
                  color: AppColors.secondary,
                  fontWeight: FontWeight.w800,
                  fontSize: 9.5,
                  letterSpacing: 0.5,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: AppSpacing.spaceSm + 2),
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.spaceMd,
            vertical: AppSpacing.spaceSm + 2,
          ),
          decoration: BoxDecoration(
            color: AppColors.surfaceContainerLow,
            borderRadius: BorderRadius.circular(AppSpacing.spaceSm),
          ),
          child: Row(
            children: [
              const Icon(
                Icons.schedule_rounded,
                size: 16,
                color: AppColors.secondary,
              ),
              const SizedBox(width: AppSpacing.spaceSm),
              Expanded(
                child: Text(
                  displayEta,
                  style: AppTypography.bodySm.copyWith(
                    color: AppColors.slateHeadline,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
