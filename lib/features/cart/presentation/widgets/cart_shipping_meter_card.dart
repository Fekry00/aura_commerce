import 'package:aura/core/theme/app_colors.dart';
import 'package:aura/core/theme/app_typography.dart';
import 'package:aura/features/cart/domain/entities/sub_entities/shipping_meter_entity.dart';
import 'package:flutter/material.dart';

/// Pure declarative UI widget for shipping progress meter and threshold indicator.
class CartShippingMeterCard extends StatelessWidget {
  final ShippingMeterEntity? meter;
  final String? remainingAmount;
  final double? progress;
  final String? percentLabel;
  final bool? isUnlocked;

  const CartShippingMeterCard({
    super.key,
    this.meter,
    this.remainingAmount,
    this.progress,
    this.percentLabel,
    this.isUnlocked,
  });

  @override
  Widget build(BuildContext context) {
    final remaining = remainingAmount ??
        (meter != null
            ? '${meter!.remainingAmount.toStringAsFixed(0)} EGP'
            : '0 EGP');
    final progressValue = progress ?? meter?.progressRatio ?? 0.0;
    final percent =
        percentLabel ?? (meter != null ? '${meter!.progressPercent}%' : '0%');
    final effectiveIsUnlocked = isUnlocked ?? meter?.isComplimentary ?? false;

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
                child: effectiveIsUnlocked
                    ? RichText(
                        text: TextSpan(
                          style: AppTypography.bodySm.copyWith(
                            color: AppColors.onSurface,
                            fontWeight: FontWeight.w500,
                          ),
                          children: [
                            TextSpan(
                              text: 'Complimentary Express Courier ',
                              style: AppTypography.bodySm.copyWith(
                                fontWeight: FontWeight.w700,
                                color: AppColors.secondary,
                              ),
                            ),
                            TextSpan(
                              text: 'Unlocked 🎉',
                              style: AppTypography.bodySm.copyWith(
                                fontWeight: FontWeight.w600,
                                color: AppColors.onSurface,
                              ),
                            ),
                          ],
                        ),
                      )
                    : RichText(
                        text: TextSpan(
                          style: AppTypography.bodySm.copyWith(
                            color: AppColors.onSurface,
                            fontWeight: FontWeight.w500,
                          ),
                          children: [
                            const TextSpan(text: 'Add '),
                            TextSpan(
                              text: remaining,
                              style: AppTypography.bodySm.copyWith(
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
