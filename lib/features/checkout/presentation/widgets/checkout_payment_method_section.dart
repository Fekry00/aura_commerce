import 'package:aura/core/theme/app_colors.dart';
import 'package:aura/core/theme/app_typography.dart';
import 'package:aura/features/checkout/presentation/widgets/checkout_section_card.dart';
import 'package:flutter/material.dart';

class CheckoutPaymentMethodSection extends StatelessWidget {
  const CheckoutPaymentMethodSection({
    super.key,
    required this.selectedMethod,
    required this.onMethodSelected,
  });

  final String selectedMethod;
  final ValueChanged<String> onMethodSelected;

  @override
  Widget build(BuildContext context) {
    return CheckoutSectionCard(
      title: 'PAYMENT METHOD',
      icon: Icons.payment_outlined,
      child: Column(
        children: [
          _buildPaymentOption(
            value: 'cod',
            title: 'Cash on Delivery (COD)',
            subtitle: 'Pay securely in cash upon courier consignment',
            icon: Icons.local_atm_rounded,
          ),
          const SizedBox(height: 10),
          _buildPaymentOption(
            value: 'card',
            title: 'Credit / Debit Card',
            subtitle: 'Visa, MasterCard, or Private Reserves Card',
            icon: Icons.credit_card_rounded,
          ),
          const SizedBox(height: 10),
          _buildPaymentOption(
            value: 'wallet',
            title: 'Digital Vault Wallet',
            subtitle: 'Instant deduction from your encrypted wallet',
            icon: Icons.account_balance_wallet_outlined,
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentOption({
    required String value,
    required String title,
    required String subtitle,
    required IconData icon,
  }) {
    final isSelected = selectedMethod == value;
    return GestureDetector(
      onTap: () => onMethodSelected(value),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: isSelected
              ? const Color(0xFF0B3B2C).withValues(alpha: 0.05)
              : Colors.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: isSelected
                ? const Color(0xFF0B3B2C)
                : const Color(0xFFE2E8F0),
            width: isSelected ? 1.5 : 1,
          ),
        ),
        child: Row(
          children: [
            Icon(
              icon,
              color: isSelected
                  ? const Color(0xFF0B3B2C)
                  : AppColors.slateBody,
              size: 22,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: AppTypography.headlineSm.copyWith(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: isSelected
                          ? const Color(0xFF0B3B2C)
                          : const Color(0xFF1E293B),
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    subtitle,
                    style: AppTypography.bodySm.copyWith(
                      fontSize: 11,
                      color: AppColors.slateBody,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: isSelected
                      ? const Color(0xFF0B3B2C)
                      : const Color(0xFFCBD5E1),
                  width: 2,
                ),
                color: isSelected
                    ? const Color(0xFF0B3B2C)
                    : Colors.transparent,
              ),
              child: isSelected
                  ? const Icon(
                      Icons.check,
                      size: 12,
                      color: Colors.white,
                    )
                  : null,
            ),
          ],
        ),
      ),
    );
  }
}
