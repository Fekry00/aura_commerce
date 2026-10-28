import 'package:aura/core/theme/app_colors.dart';
import 'package:aura/core/theme/app_typography.dart';
import 'package:aura/features/orders/domain/entities/order_entity.dart';
import 'package:aura/features/orders/presentation/widgets/tracking_milestone_step_item.dart';
import 'package:flutter/material.dart';

class TrackingMilestonesStepper extends StatelessWidget {
  final OrderEntity? order;

  const TrackingMilestonesStepper({super.key, this.order});

  @override
  Widget build(BuildContext context) {
    final status = order?.status.toLowerCase() ?? 'shipped';
    final isDelivered = status == 'delivered';
    final isShipped = status == 'shipped';
    final isPending = status == 'pending';
    final isCancelled = status == 'cancelled';

    final stepLabel = isCancelled
        ? 'CANCELLED'
        : (isDelivered
            ? 'STEP 5 OF 5'
            : (isShipped ? 'STEP 4 OF 5' : 'STEP 2 OF 5'));

    final destinationText = order?.shippingAddress.isNotEmpty == true
        ? '${order!.shippingAddress} private reception.'
        : '742 Evergreen St, Penthouse B private reception.';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Transit Milestones',
              style: AppTypography.headlineSm.copyWith(
                fontWeight: FontWeight.w700,
                color: AppColors.slateHeadline,
              ),
            ),
            Text(
              stepLabel,
              style: AppTypography.labelCaps.copyWith(
                color: isCancelled ? AppColors.error : AppColors.secondary,
                fontWeight: FontWeight.w800,
                letterSpacing: 1.0,
              ),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.spaceMd),
        TrackingMilestoneStepItem(
          title: 'Order Placed & Vault Confirmed',
          time: order?.createdAt != null
              ? order!.createdAt!.split('T').first
              : '09:15 AM',
          description: 'Cryptographic allocation verified at Aura Reserve.',
          state: MilestoneState.completed,
        ),
        TrackingMilestoneStepItem(
          title: 'Artisan Inspection & Packaging',
          time: '11:30 AM',
          description: 'Sealed with tamper-proof holographic seal #984-NY.',
          state: isCancelled
              ? MilestoneState.pending
              : (isPending ? MilestoneState.active : MilestoneState.completed),
        ),
        TrackingMilestoneStepItem(
          title: 'Dispatched from Manhattan Atelier',
          time: '01:20 PM',
          description: 'Released into climate-controlled armored custody.',
          state: (isShipped || isDelivered)
              ? MilestoneState.completed
              : MilestoneState.pending,
        ),
        TrackingMilestoneStepItem(
          title: 'Out for Courier Delivery',
          time: '02:10 PM',
          description:
              'In transit with Marcus Vance. Approaching Flatiron district.',
          state: isDelivered
              ? MilestoneState.completed
              : (isShipped ? MilestoneState.active : MilestoneState.pending),
        ),
        TrackingMilestoneStepItem(
          title: 'Delivered & White-Glove Handover',
          time: isDelivered ? 'Completed' : 'Est. 03:00 PM',
          description: destinationText,
          state: isDelivered
              ? MilestoneState.completed
              : MilestoneState.pending,
          isLast: true,
        ),
      ],
    );
  }
}
