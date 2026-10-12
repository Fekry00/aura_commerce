import 'dart:ui';
import 'package:aura/core/routing/routes.dart';
import 'package:aura/core/theme/app_colors.dart';
import 'package:aura/core/theme/app_typography.dart';
import 'package:aura/core/utils/functions/custom_snack_bar.dart';
import 'package:flutter/material.dart';

class CartBottomCheckoutTray extends StatelessWidget {
  final String totalPayable;

  const CartBottomCheckoutTray({super.key, this.totalPayable = '\$2,585.50'});

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
          filter: ImageFilter.blur(
            sigmaX: AppSpacing.spaceMd,
            sigmaY: AppSpacing.spaceMd,
          ),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(
              AppSpacing.margin,
              AppSpacing.spaceSm + AppSpacing.spaceXs,
              AppSpacing.margin,
              AppSpacing.spaceSm + AppSpacing.spaceXs,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Total Payable Row
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'BAG TOTAL PAYABLE',
                      style: AppTypography.labelCaps.copyWith(
                        color: AppColors.onSurfaceVariant,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Text(
                      totalPayable,
                      style: AppTypography.priceHero.copyWith(
                        fontSize: 22,
                        fontWeight: FontWeight.w800,
                        color: AppColors.primaryContainer,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: AppSpacing.spaceSm + 2),
                SizedBox(
                  width: double.infinity,
                  height: AppSpacing.spaceXl + AppSpacing.spaceSm + 2,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pushNamed(Routes.checkoutView);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primaryContainer,
                      foregroundColor: Colors.white,
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                          AppSpacing.margin + AppSpacing.spaceSm,
                        ),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Proceed to Checkout',
                          style: AppTypography.headlineSm.copyWith(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(width: AppSpacing.spaceSm),
                        const Icon(
                          Icons.arrow_forward_rounded,
                          size: AppSpacing.spaceMd + 2,
                          color: Colors.white,
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: AppSpacing.spaceSm),
                SizedBox(
                  width: double.infinity,
                  height: AppSpacing.spaceXl + AppSpacing.spaceXs,
                  child: ElevatedButton(
                    onPressed: () {
                      showCustomSnackBar(
                        context,
                        message: 'Initializing Express Wallet checkout...',
                        type: SnackBarType.info,
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF2D3133),
                      foregroundColor: Colors.white,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                          AppSpacing.margin + AppSpacing.spaceSm,
                        ),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Express Checkout with  ',
                          style: AppTypography.bodySm.copyWith(
                            color: Colors.white.withValues(alpha: 0.85),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const Icon(
                          Icons.credit_card_rounded,
                          size: AppSpacing.spaceMd,
                          color: Colors.white,
                        ),
                        const SizedBox(width: AppSpacing.spaceXs),
                        Text(
                          'Apple Pay / GPay',
                          style: AppTypography.bodySm.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
