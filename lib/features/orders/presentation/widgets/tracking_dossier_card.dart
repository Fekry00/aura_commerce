import 'package:aura/core/theme/app_colors.dart';
import 'package:aura/core/theme/app_typography.dart';
import 'package:aura/features/orders/presentation/widgets/tracking_dossier_row.dart';
import 'package:flutter/material.dart';

class TrackingDossierCard extends StatelessWidget {
  const TrackingDossierCard({super.key});

  @override
  Widget build(BuildContext context) {
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
          const TrackingDossierRow(
            icon: Icons.location_on_outlined,
            title: 'Claire Daniels',
            subtitle: '742 Evergreen St, Penthouse B\nManhattan, NY 10021',
          ),
          const SizedBox(height: AppSpacing.spaceMd),
          const TrackingDossierRow(
            icon: Icons.verified_user_outlined,
            title: 'Armored White-Glove Direct Courier',
            subtitle: 'Complimentary VIP Protocol (Insured up to \$50,000)',
            subtitleColor: AppColors.secondary,
          ),
          const SizedBox(height: AppSpacing.spaceMd),
          const TrackingDossierRow(
            icon: Icons.credit_card_outlined,
            title: 'Vault Pay (Amex Centurion)',
            badgeText: 'PAID',
            subtitle: '•••• 1008 • Subtotal incl. \$245.50 State Surcharge',
          ),
        ],
      ),
    );
  }
}
