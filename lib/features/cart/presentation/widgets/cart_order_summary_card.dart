import 'package:aura/core/theme/app_colors.dart';
import 'package:aura/core/theme/app_typography.dart';
import 'package:aura/features/cart/domain/entities/cart_entity.dart';
import 'package:flutter/material.dart';

/// Pure declarative UI widget presenting order subtotal, discount, shipping, tax, and total.
class CartOrderSummaryCard extends StatelessWidget {
  final CartEntity? cart;
  final String? subtotal;
  final String? discount;
  final String? discountPercentage;
  final bool? hasDiscount;
  final String shipping;
  final String? tax;
  final String? total;
  final int? itemCount;

  const CartOrderSummaryCard({
    super.key,
    this.cart,
    this.subtotal,
    this.discount,
    this.discountPercentage,
    this.hasDiscount,
    this.shipping = 'COMPLIMENTARY',
    this.tax,
    this.total,
    this.itemCount,
  });

  @override
  Widget build(BuildContext context) {
    final effectiveCount = itemCount ?? cart?.items.length ?? 0;
    final effectiveSubtotal = subtotal ?? cart?.formattedSubtotal ?? '0 EGP';
    final effectiveDiscount = discount ?? cart?.formattedOrderDiscount ?? '-0 EGP';
    final effectiveDiscountPct =
        discountPercentage ?? cart?.formattedDiscountPercentage ?? '0%';
    final effectiveHasDiscount = hasDiscount ?? cart?.hasDiscount ?? false;
    final effectiveTax = tax ?? cart?.formattedTax ?? '0 EGP';
    final effectiveTotal = total ?? cart?.formattedTotal ?? '0 EGP';

    return Container(
      padding: const EdgeInsets.all(AppSpacing.margin),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(AppSpacing.spaceMd),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: AppSpacing.spaceSm + AppSpacing.spaceXs / 2,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Order Summary',
            style: AppTypography.headlineSm.copyWith(
              fontWeight: FontWeight.w700,
              color: AppColors.onSurface,
            ),
          ),
          const SizedBox(height: AppSpacing.spaceMd),
          _buildSummaryRow(
            label:
                'Subtotal ($effectiveCount ${effectiveCount == 1 ? 'item' : 'items'})',
            value: effectiveSubtotal,
          ),
          const SizedBox(height: AppSpacing.spaceSm + AppSpacing.spaceXs / 2),
          if (effectiveHasDiscount) ...[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Privilege Discount',
                      style: AppTypography.bodyMd.copyWith(
                        color: AppColors.secondary,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(width: AppSpacing.spaceXs + 2),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppSpacing.spaceXs + 2,
                        vertical: AppSpacing.spaceXs / 2,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.secondaryContainer.withValues(
                          alpha: 0.35,
                        ),
                        borderRadius: BorderRadius.circular(AppSpacing.spaceXs),
                      ),
                      child: Text(
                        effectiveDiscountPct,
                        style: AppTypography.labelCaps.copyWith(
                          color: AppColors.secondary,
                          fontWeight: FontWeight.w700,
                          fontSize: 10,
                        ),
                      ),
                    ),
                  ],
                ),
                Text(
                  effectiveDiscount,
                  style: AppTypography.priceCatalog.copyWith(
                    color: AppColors.secondary,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.spaceSm + AppSpacing.spaceXs / 2),
          ],
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Estimated Express Shipping',
                style: AppTypography.bodyMd.copyWith(
                  color: AppColors.onSurfaceVariant,
                ),
              ),
              Text(
                shipping,
                style: AppTypography.labelCaps.copyWith(
                  color: AppColors.secondary,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.spaceSm + AppSpacing.spaceXs / 2),

          // Tax
          if ((cart?.orderSummary.tax ?? 0) > 0 || (tax != null && tax != '0 EGP')) ...[
            _buildSummaryRow(
              label: (cart?.orderSummary.taxLocation.isNotEmpty ?? false)
                  ? 'Estimated Sales Tax • ${cart!.orderSummary.taxLocation}'
                  : 'Estimated Sales Tax',
              value: effectiveTax,
            ),
            const SizedBox(height: AppSpacing.spaceSm + AppSpacing.spaceXs / 2),
          ],
          const SizedBox(height: AppSpacing.spaceMd),

          // Divider
          Container(height: 1, color: AppColors.surfaceContainerHigh),
          const SizedBox(height: AppSpacing.spaceMd - 2),

          // Total
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Total',
                    style: AppTypography.headlineSm.copyWith(
                      fontWeight: FontWeight.w700,
                      color: AppColors.onSurface,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.spaceXs / 2),
                  Text(
                    'Including Duties & Taxes',
                    style: AppTypography.bodySm.copyWith(
                      color: AppColors.onSurfaceVariant,
                      fontSize: 11,
                    ),
                  ),
                ],
              ),
              Text(
                effectiveTotal,
                style: AppTypography.priceHero.copyWith(
                  color: AppColors.onSurface,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryRow({required String label, required String value}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: AppTypography.bodyMd.copyWith(
            color: AppColors.onSurfaceVariant,
          ),
        ),
        Text(
          value,
          style: AppTypography.priceCatalog.copyWith(
            color: AppColors.onSurface,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
