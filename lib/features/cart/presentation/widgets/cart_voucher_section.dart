import 'package:aura/core/theme/app_colors.dart';
import 'package:aura/core/theme/app_typography.dart';
import 'package:aura/core/utils/functions/custom_snack_bar.dart';
import 'package:aura/features/cart/presentation/widgets/cart_controller.dart';
import 'package:flutter/material.dart';

class CartVoucherSection extends StatefulWidget {
  final CartController? controller;
  final String? activeVoucherCode;
  final String? activeVoucherLabel;
  final ValueChanged<String>? onApplyVoucher;
  final VoidCallback? onRemoveVoucher;

  const CartVoucherSection({
    super.key,
    this.controller,
    this.activeVoucherCode,
    this.activeVoucherLabel,
    this.onApplyVoucher,
    this.onRemoveVoucher,
  });

  @override
  State<CartVoucherSection> createState() => _CartVoucherSectionState();
}

class _CartVoucherSectionState extends State<CartVoucherSection> {
  final TextEditingController _textController = TextEditingController();

  @override
  void disposeWidget() {
    _textController.dispose();
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  void _handleApply() {
    final text = _textController.text.trim();
    if (text.isEmpty) {
      showCustomSnackBar(
        context,
        message: 'Please enter a promo code (e.g. WELCOME10)',
        type: SnackBarType.error,
      );
      return;
    }

    if (widget.onApplyVoucher != null) {
      widget.onApplyVoucher!(text);
    } else {
      widget.controller?.applyVoucher(text);
      showCustomSnackBar(
        context,
        message: 'Promo code applied successfully!',
        type: SnackBarType.success,
      );
    }

    _textController.clear();
    FocusScope.of(context).unfocus();
  }

  void _handleRemove() {
    if (widget.onRemoveVoucher != null) {
      widget.onRemoveVoucher!();
    } else {
      widget.controller?.removeVoucher();
      showCustomSnackBar(
        context,
        message: 'Promo code removed',
        type: SnackBarType.info,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final code =
        widget.activeVoucherCode ?? widget.controller?.activeVoucherCode;
    final label =
        widget.activeVoucherLabel ??
        widget.controller?.voucherLabel ??
        '-10% VIP Privilege';
    final hasActiveVoucher = code != null && code.isNotEmpty;

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
                    controller: _textController,
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
                    onSubmitted: (_) => _handleApply(),
                  ),
                ),
              ),
              const SizedBox(width: AppSpacing.spaceSm),
              InkWell(
                onTap: _handleApply,
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
          if (hasActiveVoucher) ...[
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
                    onTap: _handleRemove,
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
