import 'package:aura/core/theme/app_typography.dart';
import 'package:aura/features/orders/domain/entities/order_entity.dart';
import 'package:aura/features/orders/presentation/controllers/order_receipt_controller.dart';
import 'package:flutter/material.dart';
import 'order_receipt_actions_card.dart';
import 'order_receipt_consignment_card.dart';
import 'order_receipt_manifest_card.dart';
import 'order_receipt_settlement_card.dart';
import 'order_receipt_status_header.dart';

class OrderSuccessReceiptBody extends StatelessWidget {
  final OrderEntity order;
  final OrderReceiptController controller;

  const OrderSuccessReceiptBody({
    super.key,
    required this.order,
    required this.controller,
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
            onViewAllOrders: () => controller.onViewAllOrders(context),
            onReturnHome: () => controller.onReturnHome(context),
          ),
          const SizedBox(height: AppSpacing.spaceXl),
        ],
      ),
    );
  }
}
