import 'package:aura/core/theme/app_colors.dart';
import 'package:aura/core/theme/app_typography.dart';
import 'package:aura/features/orders/presentation/widgets/tracking_milestone_step_item.dart';
import 'package:flutter/material.dart';

class TrackingMilestonesStepper extends StatelessWidget {
  const TrackingMilestonesStepper({super.key});

  @override
  Widget build(BuildContext context) {
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
              'STEP 4 OF 5',
              style: AppTypography.labelCaps.copyWith(
                color: AppColors.secondary,
                fontWeight: FontWeight.w800,
                letterSpacing: 1.0,
              ),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.spaceMd),
        const TrackingMilestoneStepItem(
          title: 'Order Placed & Vault Confirmed',
          time: '09:15 AM',
          description: 'Cryptographic allocation verified at Aura Reserve.',
          state: MilestoneState.completed,
        ),
        const TrackingMilestoneStepItem(
          title: 'Artisan Inspection & Packaging',
          time: '11:30 AM',
          description: 'Sealed with tamper-proof holographic seal #984-NY.',
          state: MilestoneState.completed,
        ),
        const TrackingMilestoneStepItem(
          title: 'Dispatched from Manhattan Atelier',
          time: '01:20 PM',
          description: 'Released into climate-controlled armored custody.',
          state: MilestoneState.completed,
        ),
        const TrackingMilestoneStepItem(
          title: 'Out for Courier Delivery',
          time: '02:10 PM',
          description:
              'In transit with Marcus Vance. Approaching Flatiron district.',
          state: MilestoneState.active,
        ),
        const TrackingMilestoneStepItem(
          title: 'Delivered & White-Glove Handover',
          time: 'Est. 03:00 PM',
          description: '742 Evergreen St, Penthouse B private reception.',
          state: MilestoneState.pending,
          isLast: true,
        ),
      ],
    );
  }
}
