import 'dart:ui';
import 'package:aura/core/theme/app_colors.dart';
import 'package:aura/core/theme/app_typography.dart';
import 'package:aura/core/utils/functions/custom_snack_bar.dart';
import 'package:flutter/material.dart';

class CheckoutBottomBar extends StatelessWidget {
  final String totalPayable;
  final VoidCallback? onProceed;

  const CheckoutBottomBar({
    super.key,
    this.totalPayable = '\$2,585.50',
    this.onProceed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface.withValues(alpha: 0.95),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: AppSpacing.spaceMd,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: ClipRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 16, sigmaY: 16),
          child: SafeArea(
            top: false,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(AppSpacing.margin, 12, AppSpacing.margin, AppSpacing.spaceSm),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('TOTAL PAYABLE', style: AppTypography.labelCaps.copyWith(color: AppColors.onSurfaceVariant, fontWeight: FontWeight.w700)),
                          const SizedBox(height: 2),
                          Text(totalPayable, style: AppTypography.priceHero.copyWith(fontSize: 22, fontWeight: FontWeight.w800, color: AppColors.primaryContainer)),
                        ],
                      ),
                      const SizedBox(width: AppSpacing.spaceMd),
                      Expanded(
                        child: SizedBox(
                          height: 48,
                          child: ElevatedButton(
                            onPressed: onProceed ?? () => showCustomSnackBar(context, message: 'Proceeding to Payment Gateways...', type: SnackBarType.success),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.primaryContainer,
                              foregroundColor: Colors.white,
                              elevation: 2,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text('Proceed to Payment', style: AppTypography.labelSm.copyWith(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 14)),
                                const SizedBox(width: 6),
                                const Icon(Icons.arrow_forward_rounded, size: 18, color: Colors.white),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.spaceSm),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.verified_rounded, size: 13, color: AppColors.secondary),
                      const SizedBox(width: 4),
                      Text(
                        'MONEY BACK GUARANTEE • COMPLIMENTARY GLOBAL RETURNS',
                        style: AppTypography.labelCaps.copyWith(color: AppColors.onSurfaceVariant, fontWeight: FontWeight.w700, fontSize: 9.5),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
