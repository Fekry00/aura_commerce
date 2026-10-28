import 'package:aura/core/theme/app_colors.dart';
import 'package:aura/core/theme/app_typography.dart';
import 'package:aura/features/orders/domain/entities/order_entity.dart';
import 'package:aura/features/orders/presentation/widgets/tracking_dossier_row.dart';
import 'package:flutter/material.dart';

class TrackingDossierCard extends StatelessWidget {
  final OrderEntity? order;

  const TrackingDossierCard({super.key, this.order});

  @override
  Widget build(BuildContext context) {
    final addressText = order?.shippingAddress.isNotEmpty == true
        ? order!.shippingAddress
        : '742 Evergreen St, Penthouse B\nManhattan, NY 10021';
    final paymentTitle = order != null
        ? (order!.paymentMethod.toLowerCase() == 'cod'
            ? 'Cash on Delivery Protocol'
            : 'Vault Pay (${order!.paymentMethod.toUpperCase()})')
        : 'Vault Pay (Amex Centurion)';
    final paymentSubtitle = order != null
        ? 'Total Authorized: \$${order!.totalAmount.toStringAsFixed(2)}'
        : '•••• 1008 • Subtotal incl. \$245.50 State Surcharge';
    final paymentBadge = order != null
        ? (order!.isPending ? 'PENDING' : 'VERIFIED')
        : 'PAID';

    return Container(
      padding: const EdgeInsets.all(AppSpacing.spaceMd),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(AppSpacing.spaceMd),
        border: Border.all(
          color: AppColors.outlineVariant.withValues(alpha: 0.5),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Delivery & Payment Dossier',
            style: AppTypography.headlineSm.copyWith(
              fontWeight: FontWeight.w700,
              color: AppColors.slateHeadline,
            ),
          ),
          const SizedBox(height: AppSpacing.spaceMd),
          TrackingDossierRow(
            icon: Icons.location_on_outlined,
            title: 'Consignee Recipient',
            subtitle: addressText,
          ),
          const SizedBox(height: AppSpacing.spaceMd),
          const TrackingDossierRow(
            icon: Icons.verified_user_outlined,
            title: 'Armored White-Glove Direct Courier',
            subtitle: 'Complimentary VIP Protocol (Insured up to \$50,000)',
            subtitleColor: AppColors.secondary,
          ),
          const SizedBox(height: AppSpacing.spaceMd),
          TrackingDossierRow(
            icon: Icons.credit_card_outlined,
            title: paymentTitle,
            badgeText: paymentBadge,
            subtitle: paymentSubtitle,
          ),
        ],
      ),
    );
  }
}
