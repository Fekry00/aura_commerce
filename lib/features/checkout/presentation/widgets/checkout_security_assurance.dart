import 'package:aura/core/theme/app_typography.dart';
import 'package:flutter/material.dart';

class CheckoutSecurityAssurance extends StatelessWidget {
  const CheckoutSecurityAssurance({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.space12),
      decoration: BoxDecoration(
        color: const Color(0xFFF8FAFC),
        borderRadius: BorderRadius.circular(AppSpacing.space12),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.shield_outlined, size: 16, color: Color(0xFF0B3B2C)),
          const SizedBox(width: AppSpacing.spaceSm),
          Text(
            'Encrypted 256-bit Protocol • Insured Vault Transit',
            style: AppTypography.labelCaps.copyWith(
              color: const Color(0xFF475569),
            ),
          ),
        ],
      ),
    );
  }
}
