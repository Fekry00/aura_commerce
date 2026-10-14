import 'package:aura/core/routing/routes.dart';
import 'package:aura/core/theme/app_colors.dart';
import 'package:aura/core/theme/app_typography.dart';
import 'package:aura/features/orders/presentation/widgets/order_consignment_address_card.dart';
import 'package:aura/features/orders/presentation/widgets/order_dispatch_schedule_card.dart';
import 'package:aura/features/orders/presentation/widgets/order_guarantee_badges.dart';
import 'package:aura/features/orders/presentation/widgets/order_receipt_app_bar.dart';
import 'package:aura/features/orders/presentation/widgets/order_settlement_summary_card.dart';
import 'package:aura/features/orders/presentation/widgets/order_success_actions.dart';
import 'package:aura/features/orders/presentation/widgets/order_success_header.dart';
import 'package:aura/features/orders/presentation/widgets/order_vault_manifest_section.dart';
import 'package:flutter/material.dart';

class OrderSuccessReceiptView extends StatelessWidget {
  const OrderSuccessReceiptView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surface,
      appBar: const OrderReceiptAppBar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.gutter,
          vertical: AppSpacing.spaceSm,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const OrderSuccessHeader(),
            const SizedBox(height: AppSpacing.spaceMd),
            const OrderDispatchScheduleCard(),
            const SizedBox(height: AppSpacing.spaceLg),
            const OrderVaultManifestSection(),
            const SizedBox(height: AppSpacing.spaceLg),
            const OrderConsignmentAddressCard(),
            const SizedBox(height: AppSpacing.spaceLg),
            const OrderSettlementSummaryCard(),
            const SizedBox(height: AppSpacing.spaceLg),
            const OrderGuaranteeBadges(),
            const SizedBox(height: AppSpacing.spaceLg),
            OrderSuccessActions(
              onTrackCourier: () => Navigator.pushNamed(
                context,
                Routes.orderTrackingDetailsView,
              ),
              onDownloadInvoice: () {},
              onContactLiaison: () {},
            ),
            const SizedBox(height: AppSpacing.spaceXl),
          ],
        ),
      ),
    );
  }
}
