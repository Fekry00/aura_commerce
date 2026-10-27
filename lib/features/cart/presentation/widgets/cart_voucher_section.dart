import 'package:aura/core/theme/app_colors.dart';
import 'package:aura/core/theme/app_typography.dart';
import 'package:aura/features/cart/presentation/controllers/cart_controller.dart';
import 'package:flutter/material.dart';

/// Pure declarative UI widget for voucher code entry and active privilege badge.
class CartVoucherSection extends StatelessWidget {
  final CartController controller;
  final VoidCallback? onApply;
  final VoidCallback? onRemove;

  const CartVoucherSection({
    super.key,
    required this.controller,
    this.onApply,
    this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    final code = controller.activeVoucherCode;
    final label = controller.voucherLabel ?? '-10% VIP Privilege';
    final hasActiveVoucher = controller.hasDiscount;

    return Container(
      padding: const EdgeInsets.all(AppSpacing.spaceMd),
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
            'VOUCHER PRIVILEGE',
            style: AppTypography.labelCaps.copyWith(
              color: AppColors.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: AppSpacing.spaceSm + AppSpacing.spaceXs),
          Row(
            children: [
              Expanded(
                child: Container(
                  height: AppSpacing.spaceXl + AppSpacing.spaceSm,
                  decoration: BoxDecoration(
                    color: AppColors.surfaceContainerLow,
                    borderRadius: BorderRadius.circular(AppSpacing.spaceLg),
                  ),
                  child: TextField(
                    controller: controller.voucherInputController,
                    textCapitalization: TextCapitalization.characters,
                    style: AppTypography.bodyMd.copyWith(
                      color: AppColors.onSurface,
                      fontWeight: FontWeight.w500,
                    ),
                    decoration: InputDecoration(
                      hintText: 'Enter promo code',
                      hintStyle: AppTypography.bodyMd.copyWith(
                        color: AppColors.outline,
                        fontSize: 13,
                      ),
                      prefixIcon: const Icon(
                        Icons.sell_outlined,
                        size: AppSpacing.spaceMd + 2,
                        color: AppColors.outline,
                      ),
                      border: InputBorder.none,
                      contentPadding: const EdgeInsets.symmetric(
                        vertical: AppSpacing.spaceMd - 2,
                        horizontal: AppSpacing.spaceMd,
                      ),
                    ),
                    onSubmitted: (_) =>
                        onApply != null ? onApply!() : controller.onApplyVoucher(context),
                  ),
                ),
              ),
              const SizedBox(width: AppSpacing.spaceSm),
              InkWell(
                onTap: () =>
                    onApply != null ? onApply!() : controller.onApplyVoucher(context),
                borderRadius: BorderRadius.circular(AppSpacing.spaceLg),
                child: Container(
                  height: AppSpacing.spaceXl + AppSpacing.spaceSm,
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.margin,
                  ),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: AppColors.secondaryContainer,
                    borderRadius: BorderRadius.circular(AppSpacing.spaceLg),
                  ),
                  child: Text(
                    'Apply',
                    style: AppTypography.labelSm.copyWith(
                      fontWeight: FontWeight.w700,
                      color: AppColors.primary,
                      fontSize: 13,
                    ),
                  ),
                ),
              ),
            ],
          ),
          if (hasActiveVoucher && code != null) ...[
            const SizedBox(height: AppSpacing.spaceSm + AppSpacing.spaceXs),
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.spaceSm + AppSpacing.spaceXs,
                vertical: AppSpacing.spaceSm,
              ),
              decoration: BoxDecoration(
                color: AppColors.surfaceContainerLow,
                borderRadius: BorderRadius.circular(
                  AppSpacing.spaceSm + AppSpacing.spaceXs / 2,
                ),
              ),
              child: Row(
                children: [
                  const Icon(
                    Icons.check_circle,
                    size: AppSpacing.spaceMd + 2,
                    color: AppColors.secondary,
                  ),
                  const SizedBox(width: AppSpacing.spaceSm),
                  Text(
                    code,
                    style: AppTypography.bodySm.copyWith(
                      fontWeight: FontWeight.w700,
                      color: AppColors.onSurface,
                    ),
                  ),
                  const SizedBox(width: AppSpacing.spaceSm),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.spaceSm,
                      vertical: AppSpacing.spaceXs / 2,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.secondaryContainer.withValues(
                        alpha: 0.4,
                      ),
                      borderRadius: BorderRadius.circular(AppSpacing.margin),
                    ),
                    child: Text(
                      label,
                      style: AppTypography.labelCaps.copyWith(
                        color: AppColors.secondary,
                        fontWeight: FontWeight.w700,
                        fontSize: 10,
                      ),
                    ),
                  ),
                  const Spacer(),
                  InkWell(
                    onTap: () => onRemove != null
                        ? onRemove!()
                        : controller.onRemoveVoucher(context),
                    borderRadius: BorderRadius.circular(
                      AppSpacing.spaceSm + AppSpacing.spaceXs,
                    ),
                    child: const Padding(
                      padding: EdgeInsets.all(AppSpacing.spaceXs),
                      child: Icon(
                        Icons.close,
                        size: AppSpacing.spaceMd,
                        color: AppColors.outline,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }
}
