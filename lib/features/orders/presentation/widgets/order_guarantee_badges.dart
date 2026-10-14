import 'package:aura/core/theme/app_colors.dart';
import 'package:aura/core/theme/app_typography.dart';
import 'package:aura/features/orders/presentation/widgets/order_guarantee_tile.dart';
import 'package:flutter/material.dart';

class OrderGuaranteeBadges extends StatelessWidget {
  const OrderGuaranteeBadges({super.key});

  static const _badges = [
    (icon: Icons.view_in_ar_outlined, label: 'NFC Cryptographic\nSeal'),
    (icon: Icons.inventory_2_outlined, label: 'Tamper-Evident\nCasket'),
    (icon: Icons.sync_rounded, label: '30-Day Valet\nReturns'),
    (icon: Icons.shield_outlined, label: "Full Lloyd's\nCoverage"),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.spaceMd),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(AppSpacing.spaceMd),
        border: Border.all(color: AppColors.secondary.withValues(alpha: 0.15)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 26,
                height: 26,
                decoration: BoxDecoration(
                  color: AppColors.secondary.withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.workspace_premium_outlined,
                  size: 15,
                  color: AppColors.secondary,
                ),
              ),
              const SizedBox(width: AppSpacing.spaceSm),
              Text(
                'The Aura Luxe Guarantee',
                style: AppTypography.bodyMd.copyWith(
                  fontWeight: FontWeight.w700,
                  color: AppColors.slateHeadline,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.spaceMd),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: _badges.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: AppSpacing.spaceSm,
              crossAxisSpacing: AppSpacing.spaceSm,
              childAspectRatio: 3.2,
            ),
            itemBuilder: (_, i) => OrderGuaranteeTile(
              icon: _badges[i].icon,
              label: _badges[i].label,
            ),
          ),
        ],
      ),
    );
  }
}
