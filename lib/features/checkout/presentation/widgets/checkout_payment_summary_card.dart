import 'package:aura/core/theme/app_colors.dart';
import 'package:aura/core/theme/app_typography.dart';
import 'package:aura/features/checkout/presentation/widgets/checkout_section_card.dart';
import 'package:flutter/material.dart';

class CheckoutPaymentSummaryCard extends StatelessWidget {
  const CheckoutPaymentSummaryCard({
    super.key,
    required this.itemsCount,
    required this.subtotal,
    required this.totalAmount,
    this.shippingFeeText = 'FREE',
  });

  final int itemsCount;
  final num subtotal;
  final num totalAmount;
  final String shippingFeeText;

  @override
  Widget build(BuildContext context) {
    return CheckoutSectionCard(
      title: 'SETTLEMENT SUMMARY',
      icon: Icons.receipt_long_outlined,
      child: Column(
        children: [
          _buildSummaryRow(
            'Items in Cart',
            '$itemsCount items',
          ),
          const SizedBox(height: 8),
          _buildSummaryRow(
            'Subtotal',
            '${subtotal.toStringAsFixed(2)} EGP',
          ),
          const SizedBox(height: 8),
          _buildSummaryRow(
            'Armored Courier Delivery',
            shippingFeeText,
            valueColor: const Color(0xFF006C49),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: Divider(color: Color(0xFFE2E8F0)),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Total Payable',
                style: AppTypography.headlineSm.copyWith(
                  fontSize: 16,
                  fontWeight: FontWeight.w800,
                  color: const Color(0xFF002419),
                ),
              ),
              Text(
                '${totalAmount.toStringAsFixed(2)} EGP',
                style: AppTypography.priceHero.copyWith(
                  fontSize: 20,
                  fontWeight: FontWeight.w900,
                  color: const Color(0xFF0B3B2C),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryRow(String label, String value, {Color? valueColor}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: AppTypography.bodySm.copyWith(
            color: AppColors.slateBody,
            fontSize: 13,
          ),
        ),
        Text(
          value,
          style: AppTypography.bodySm.copyWith(
            fontWeight: FontWeight.w700,
            color: valueColor ?? const Color(0xFF1E293B),
            fontSize: 13,
          ),
        ),
      ],
    );
  }
}
