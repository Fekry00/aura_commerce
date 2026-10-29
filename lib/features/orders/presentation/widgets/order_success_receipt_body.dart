import 'package:aura/core/routing/routes.dart';
import 'package:aura/core/theme/app_typography.dart';
import 'package:aura/features/orders/domain/entities/order_entity.dart';
import 'package:flutter/material.dart';
import 'order_receipt_actions_card.dart';
import 'order_receipt_consignment_card.dart';
import 'order_receipt_manifest_card.dart';
import 'order_receipt_settlement_card.dart';
import 'order_receipt_status_header.dart';

class OrderSuccessReceiptBody extends StatelessWidget {
  final OrderEntity order;
  final VoidCallback onViewAllOrders;
  final VoidCallback onReturnHome;

  const OrderSuccessReceiptBody({
    super.key,
    required this.order,
    required this.onViewAllOrders,
    required this.onReturnHome,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.gutter,
        vertical: AppSpacing.spaceSm,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          OrderReceiptStatusHeader(order: order),
          const SizedBox(height: AppSpacing.spaceMd),
          OrderReceiptManifestCard(order: order),
          const SizedBox(height: AppSpacing.spaceLg),
          OrderReceiptConsignmentCard(order: order),
          const SizedBox(height: AppSpacing.spaceLg),
          OrderReceiptSettlementCard(order: order),
          const SizedBox(height: AppSpacing.spaceLg),
          OrderReceiptActionsCard(
            onTrackOrder: () {
              Navigator.pushNamed(
                context,
                Routes.orderTrackingDetailsView,
                arguments: order,
              );
            },
            onViewAllOrders: onViewAllOrders,
            onReturnHome: onReturnHome,
          ),
          const SizedBox(height: AppSpacing.spaceXl),
        ],
      ),
    );
  }
}
