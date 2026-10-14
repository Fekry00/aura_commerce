import 'package:aura/core/theme/app_colors.dart';
import 'package:aura/core/theme/app_typography.dart';
import 'package:aura/features/orders/presentation/widgets/order_ref_capsule.dart';
import 'package:aura/features/orders/presentation/widgets/order_success_vault_emblem.dart';
import 'package:flutter/material.dart';

class OrderSuccessHeader extends StatelessWidget {
  final String recipientName;
  final String orderRef;

  const OrderSuccessHeader({
    super.key,
    this.recipientName = 'Ahmed',
    this.orderRef = '#AL-98421',
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.spaceSm,
        vertical: AppSpacing.spaceSm,
      ),
      child: Column(
        children: [
          const OrderSuccessVaultEmblem(),
          const SizedBox(height: AppSpacing.spaceMd),
          Text(
            'PRIVATE VAULT ALLOCATION',
            style: AppTypography.labelCaps.copyWith(
              color: AppColors.secondary,
              fontWeight: FontWeight.w700,
              letterSpacing: 1.4,
              fontSize: 10.5,
            ),
          ),
          const SizedBox(height: AppSpacing.spaceSm),
          Text(
            'Acquisition Confirmed',
            textAlign: TextAlign.center,
            style: AppTypography.headlineLg.copyWith(
              fontWeight: FontWeight.w700,
              color: AppColors.slateHeadline,
              letterSpacing: -0.5,
            ),
          ),
          const SizedBox(height: AppSpacing.spaceSm),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.spaceSm),
            child: Text(
              'Thank you for your patronage, $recipientName. Your curated pieces are now secured in the atelier vault for white-glove dispatch.',
              textAlign: TextAlign.center,
              style: AppTypography.bodySm.copyWith(
                color: AppColors.slateBody,
                height: 1.5,
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.spaceMd),
          OrderRefCapsule(orderRef: orderRef),
        ],
      ),
    );
  }
}
