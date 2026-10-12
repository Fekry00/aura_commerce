import 'package:aura/core/theme/app_colors.dart';
import 'package:aura/core/theme/app_typography.dart';
import 'package:flutter/material.dart';

class CheckoutPaymentSummaryCard extends StatelessWidget {
  final String subtotal;
  final String discount;
  final String shippingFee;
  final String tax;
  final String total;
  final String itemsCountText;

  const CheckoutPaymentSummaryCard({
    super.key,
    this.subtotal = '\$2,660.00',
    this.discount = '-\$266.00',
    this.shippingFee = 'COMPLIMENTARY',
    this.tax = '\$191.50',
    this.total = '\$2,585.50',
    this.itemsCountText = '3 Items Selected',
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(AppSpacing.spaceMd),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(AppSpacing.spaceMd),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Payment Summary', style: AppTypography.headlineSm.copyWith(fontWeight: FontWeight.w700)),
                    Text(itemsCountText, style: AppTypography.bodySm.copyWith(color: AppColors.onSurfaceVariant)),
                  ],
                ),
                const SizedBox(height: AppSpacing.spaceMd),
                _row('Subtotal', subtotal, isBold: true),
                const SizedBox(height: 10),
                _discountRow('Privilege Discount', discount, '10% OFF'),
                const SizedBox(height: 10),
                _shippingRow('Armored Courier Delivery', shippingFee),
                const SizedBox(height: 10),
                _row('Estimated Luxury Duties & Taxes', tax),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(AppSpacing.spaceMd),
            decoration: BoxDecoration(
              color: AppColors.surfaceContainerLow.withValues(alpha: 0.6),
              borderRadius: const BorderRadius.vertical(bottom: Radius.circular(AppSpacing.spaceMd)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Total Amount', style: AppTypography.headlineSm.copyWith(fontWeight: FontWeight.w700)),
                    Text('All taxes & duties covered', style: AppTypography.bodySm.copyWith(color: AppColors.onSurfaceVariant, fontSize: 11)),
                  ],
                ),
                Text(total, style: AppTypography.priceHero.copyWith(fontWeight: FontWeight.w800, fontSize: 22, color: AppColors.primaryContainer)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _row(String label, String value, {bool isBold = false}) => Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text(label, style: AppTypography.bodyMd.copyWith(color: AppColors.onSurfaceVariant)),
      Text(value, style: AppTypography.bodyMd.copyWith(color: AppColors.onSurface, fontWeight: isBold ? FontWeight.w600 : FontWeight.w500)),
    ],
  );

  Widget _discountRow(String label, String value, String tag) => Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Row(
        children: [
          Text(label, style: AppTypography.bodyMd.copyWith(color: AppColors.secondary, fontWeight: FontWeight.w500)),
          const SizedBox(width: 6),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
            decoration: BoxDecoration(color: AppColors.secondaryContainer.withValues(alpha: 0.4), borderRadius: BorderRadius.circular(4)),
            child: Text(tag, style: AppTypography.labelCaps.copyWith(color: AppColors.secondary, fontWeight: FontWeight.w800, fontSize: 9.5)),
          ),
        ],
      ),
      Text(value, style: AppTypography.bodyMd.copyWith(color: AppColors.secondary, fontWeight: FontWeight.w700)),
    ],
  );

  Widget _shippingRow(String label, String fee) => Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Row(
        children: [
          Text(label, style: AppTypography.bodyMd.copyWith(color: AppColors.onSurfaceVariant)),
          const SizedBox(width: 4),
          const Icon(Icons.shield_outlined, size: 14, color: AppColors.secondary),
        ],
      ),
      Row(
        children: [
          Text('\$40.00', style: AppTypography.bodySm.copyWith(color: AppColors.outline, decoration: TextDecoration.lineThrough)),
          const SizedBox(width: 6),
          Text(fee, style: AppTypography.labelCaps.copyWith(color: AppColors.secondary, fontWeight: FontWeight.w800)),
        ],
      ),
    ],
  );
}
