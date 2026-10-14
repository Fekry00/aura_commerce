import 'package:aura/core/theme/app_colors.dart';
import 'package:aura/core/theme/app_typography.dart';
import 'package:aura/features/orders/presentation/widgets/order_receipt_app_bar.dart';
import 'package:aura/features/orders/presentation/widgets/tracking_action_buttons.dart';
import 'package:aura/features/orders/presentation/widgets/tracking_courier_liaison_card.dart';
import 'package:aura/features/orders/presentation/widgets/tracking_curated_dispatch_items.dart';
import 'package:aura/features/orders/presentation/widgets/tracking_dossier_card.dart';
import 'package:aura/features/orders/presentation/widgets/tracking_header_status.dart';
import 'package:aura/features/orders/presentation/widgets/tracking_live_map_card.dart';
import 'package:aura/features/orders/presentation/widgets/tracking_milestones_stepper.dart';
import 'package:flutter/material.dart';

class OrderTrackingDetailsView extends StatelessWidget {
  const OrderTrackingDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surface,
      appBar: const OrderReceiptAppBar(title: 'Dispatch Logistics'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.gutter,
          vertical: AppSpacing.spaceSm,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const TrackingHeaderStatus(),
            const SizedBox(height: AppSpacing.spaceLg),
            const TrackingLiveMapCard(),
            const SizedBox(height: AppSpacing.spaceLg),
            const TrackingCourierLiaisonCard(),
            const SizedBox(height: AppSpacing.spaceLg),
            const TrackingMilestonesStepper(),
            const SizedBox(height: AppSpacing.spaceLg),
            const TrackingCuratedDispatchItems(),
            const SizedBox(height: AppSpacing.spaceLg),
            const TrackingDossierCard(),
            const SizedBox(height: AppSpacing.spaceLg),
            TrackingActionButtons(
              onDownloadInvoice: () {},
              onConciergeAssist: () {},
            ),
            const SizedBox(height: AppSpacing.spaceXl),
          ],
        ),
      ),
    );
  }
}
