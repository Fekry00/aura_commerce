import 'package:aura/core/theme/app_typography.dart';
import 'package:aura/features/orders/domain/entities/order_entity.dart';
import 'package:aura/features/orders/presentation/controllers/order_tracking_controller.dart';
import 'package:aura/features/orders/presentation/widgets/tracking_action_buttons.dart';
import 'package:aura/features/orders/presentation/widgets/tracking_courier_liaison_card.dart';
import 'package:aura/features/orders/presentation/widgets/tracking_curated_dispatch_items.dart';
import 'package:aura/features/orders/presentation/widgets/tracking_dossier_card.dart';
import 'package:aura/features/orders/presentation/widgets/tracking_header_status.dart';
import 'package:aura/features/orders/presentation/widgets/tracking_live_map_card.dart';
import 'package:aura/features/orders/presentation/widgets/tracking_milestones_stepper.dart';
import 'package:flutter/material.dart';

class OrderTrackingDetailsBody extends StatelessWidget {
  final OrderTrackingController controller;
  final OrderEntity order;

  const OrderTrackingDetailsBody({
    super.key,
    required this.controller,
    required this.order,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const AlwaysScrollableScrollPhysics(
        parent: BouncingScrollPhysics(),
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.gutter,
        vertical: AppSpacing.spaceSm,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TrackingHeaderStatus(order: order),
          const SizedBox(height: AppSpacing.spaceLg),
          const TrackingLiveMapCard(),
          const SizedBox(height: AppSpacing.spaceLg),
          TrackingCourierLiaisonCard(
            onCall: () => controller.onCallCourier(context),
            onMessage: () => controller.onMessageCourier(context),
          ),
          const SizedBox(height: AppSpacing.spaceLg),
          TrackingMilestonesStepper(order: order),
          const SizedBox(height: AppSpacing.spaceLg),
          TrackingCuratedDispatchItems(
            items: order.items,
            onInspectCertificate: () =>
                controller.onInspectCertificate(context),
          ),
          const SizedBox(height: AppSpacing.spaceLg),
          TrackingDossierCard(order: order),
          const SizedBox(height: AppSpacing.spaceLg),
          TrackingActionButtons(
            onDownloadInvoice: () => controller.onDownloadInvoice(context),
            onConciergeAssist: () => controller.onConciergeAssist(context),
          ),
          const SizedBox(height: AppSpacing.spaceXl),
        ],
      ),
    );
  }
}
