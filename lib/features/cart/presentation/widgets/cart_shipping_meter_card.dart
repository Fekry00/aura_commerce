import 'package:aura/core/theme/app_colors.dart';
import 'package:aura/core/theme/app_typography.dart';
import 'package:aura/features/cart/presentation/widgets/cart_controller.dart';
import 'package:flutter/material.dart';

class CartShippingMeterCard extends StatelessWidget {
  final CartController? controller;
  final String? remainingAmount;
  final double? progress;
  final String? percentLabel;

  const CartShippingMeterCard({
    super.key,
    this.controller,
    this.remainingAmount,
    this.progress,
    this.percentLabel,
  });

  @override
  Widget build(BuildContext context) {
    final remaining = remainingAmount ??
        controller?.formattedShippingRemaining ??
        '\$50.00';
    final progressValue = progress ?? controller?.shippingProgressRatio ?? 0.85;
    final percent = percentLabel ??
        (controller != null ? '${controller!.shippingPercent}%' : '85%');

    return Container(
      padding: const EdgeInsets.all(AppSpacing.spaceMd),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerLow,
        borderRadius: BorderRadius.circular(AppSpacing.spaceMd),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(
                Icons.local_shipping_rounded,
                size: AppSpacing.spaceLg,
                color: AppColors.secondary,
              ),
              const SizedBox(width: AppSpacing.spaceSm),
              Expanded(
                child: RichText(
                  text: TextSpan(
                    style: AppTypography.bodySm.copyWith(
                      color: AppColors.onSurface,
                      fontWeight: FontWeight.w500,
                    ),
                    children: [
                      const TextSpan(text: 'Add '),
                      TextSpan(
                        text: remaining,
                        style: const TextStyle(
                          fontWeight: FontWeight.w700,
                          color: AppColors.secondary,
                        ),
                      ),
                      const TextSpan(
                        text: ' more for Complimentary Express Courier',
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: AppSpacing.spaceSm),
              Text(
                percent,
                style: AppTypography.labelCaps.copyWith(
                  fontWeight: FontWeight.w700,
                  color: AppColors.onSurfaceVariant,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.spaceSm + AppSpacing.spaceXs / 2),
          ClipRRect(
            borderRadius: BorderRadius.circular(AppSpacing.margin),
            child: LinearProgressIndicator(
              value: progressValue,
              minHeight: AppSpacing.spaceSm,
              backgroundColor: AppColors.surfaceContainer,
              valueColor: const AlwaysStoppedAnimation<Color>(
                AppColors.secondaryContainer,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
