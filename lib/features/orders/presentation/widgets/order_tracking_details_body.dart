import 'package:aura/core/theme/app_typography.dart';
import 'package:aura/core/utils/functions/custom_snack_bar.dart';
import 'package:aura/features/orders/domain/entities/order_entity.dart';
import 'package:aura/features/orders/presentation/cubit/orders_cubit.dart';
import 'package:aura/features/orders/presentation/widgets/tracking_action_buttons.dart';
import 'package:aura/features/orders/presentation/widgets/tracking_courier_liaison_card.dart';
import 'package:aura/features/orders/presentation/widgets/tracking_curated_dispatch_items.dart';
import 'package:aura/features/orders/presentation/widgets/tracking_dossier_card.dart';
import 'package:aura/features/orders/presentation/widgets/tracking_header_status.dart';
import 'package:aura/features/orders/presentation/widgets/tracking_live_map_card.dart';
import 'package:aura/features/orders/presentation/widgets/tracking_milestones_stepper.dart';
import 'package:aura/features/orders/presentation/widgets/tracking_nft_certificate_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OrderTrackingDetailsBody extends StatelessWidget {
  final OrderEntity order;

  const OrderTrackingDetailsBody({
    super.key,
    required this.order,
  });

  void _onCallCourier(BuildContext context) {
    showCustomSnackBar(
      context,
      message: 'Dialing courier dispatch for Order #AUR-${order.id}...',
      type: SnackBarType.success,
    );
  }

  void _onMessageCourier(BuildContext context) {
    showCustomSnackBar(
      context,
      message: 'Opening encrypted courier thread for Order #AUR-${order.id}...',
      type: SnackBarType.success,
    );
  }

  void _onInspectCertificate(BuildContext context) {
    TrackingNftCertificateSheet.show(context);
  }

  void _onDownloadInvoice(BuildContext context) {
    context.read<OrdersCubit>().downloadInvoice(order.id.toString());
    showCustomSnackBar(
      context,
      message: 'Generating cryptographically signed invoice PDF...',
      type: SnackBarType.info,
    );
  }

  void _onConciergeAssist(BuildContext context) {
    showCustomSnackBar(
      context,
      message: 'Connecting to Aura 24/7 Private Concierge Desk...',
      type: SnackBarType.info,
    );
  }

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
            courierName: order.isDelivered
                ? 'Aura Delivery Complete'
                : (order.isShipped ? 'Aura Active Transit Liaison' : 'Aura Fulfillment Specialist'),
            courierRole: order.isDelivered
                ? 'Delivered to ${order.shippingAddress}'
                : (order.isShipped
                    ? 'White-Glove Private Transit (${order.shippingAddress})'
                    : 'Dispatch Preparation • Order #AUR-${order.id}'),
            courierBadge: 'Status: ${order.status.toUpperCase()}',
            onCall: () => _onCallCourier(context),
            onMessage: () => _onMessageCourier(context),
          ),
          const SizedBox(height: AppSpacing.spaceLg),
          TrackingMilestonesStepper(order: order),
          const SizedBox(height: AppSpacing.spaceLg),
          TrackingCuratedDispatchItems(
            items: order.items,
            onInspectCertificate: () => _onInspectCertificate(context),
          ),
          const SizedBox(height: AppSpacing.spaceLg),
          TrackingDossierCard(order: order),
          const SizedBox(height: AppSpacing.spaceLg),
          TrackingActionButtons(
            onDownloadInvoice: () => _onDownloadInvoice(context),
            onConciergeAssist: () => _onConciergeAssist(context),
          ),
          const SizedBox(height: AppSpacing.spaceXl),
        ],
      ),
    );
  }
}
