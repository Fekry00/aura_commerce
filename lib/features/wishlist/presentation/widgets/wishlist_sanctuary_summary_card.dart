import 'package:aura/core/theme/app_colors.dart';
import 'package:aura/core/theme/app_typography.dart';
import 'package:flutter/material.dart';
import 'wishlist_add_all_button.dart';
import 'wishlist_armored_badge.dart';

class WishlistSanctuarySummaryCard extends StatelessWidget {
  final double totalAmount;
  final int itemCount;
  final VoidCallback? onAddAllTap;

  const WishlistSanctuarySummaryCard({
    super.key,
    this.totalAmount = 0.0,
    this.itemCount = 0,
    this.onAddAllTap,
  });

  @override
  Widget build(BuildContext context) {
    final formattedPrice =
        '${totalAmount.toStringAsFixed(totalAmount % 1 == 0 ? 0 : 2)} EGP';

    return Container(
      decoration: BoxDecoration(
        color: AppColors.primaryContainer,
        borderRadius: BorderRadius.circular(AppSpacing.spaceMd),
        boxShadow: [
          BoxShadow(
            color: AppColors.primaryContainer.withValues(alpha: 0.25),
            blurRadius: AppSpacing.spaceLg,
            offset: const Offset(0, AppSpacing.spaceSm),
          ),
        ],
      ),
      padding: const EdgeInsets.all(AppSpacing.spaceMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'SANCTUARY SUMMARY',
                    style: AppTypography.labelCaps.copyWith(
                      color: AppColors.onPrimaryContainer,
                      letterSpacing: 1.0,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.spaceXs / 2),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.baseline,
                    textBaseline: TextBaseline.alphabetic,
                    children: [
                      Text(
                        formattedPrice,
                        style: AppTypography.headlineSm.copyWith(
                          color: AppColors.onPrimary,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(width: AppSpacing.spaceSm),
                      Text(
                        '$itemCount ${itemCount == 1 ? 'curation' : 'curations'}',
                        style: AppTypography.bodySm.copyWith(
                          color: AppColors.onPrimaryContainer,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const WishlistArmoredBadge(),
            ],
          ),
          const SizedBox(height: AppSpacing.spaceSm + 2),
          Text(
            'Complimentary bespoke packaging, temperature-controlled transit, and signature arrival handling included.',
            style: AppTypography.bodySm.copyWith(
              color: AppColors.onPrimaryContainer,
              height: 1.4,
            ),
          ),
          const SizedBox(height: AppSpacing.spaceMd),
          WishlistAddAllButton(onPressed: onAddAllTap),
        ],
      ),
    );
  }
}
