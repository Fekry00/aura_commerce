import 'package:aura/core/theme/app_colors.dart';
import 'package:aura/core/theme/app_typography.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class OrderRefCapsule extends StatelessWidget {
  final String orderRef;

  const OrderRefCapsule({super.key, this.orderRef = '#AL-98421'});

  void _copy(BuildContext context) {
    Clipboard.setData(ClipboardData(text: orderRef));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Order reference copied to clipboard',
          style: AppTypography.bodySm.copyWith(color: AppColors.onPrimary),
        ),
        backgroundColor: AppColors.primaryContainer,
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 2),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSpacing.spaceSm),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => _copy(context),
      borderRadius: BorderRadius.circular(AppSpacing.margin),
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.spaceMd,
          vertical: AppSpacing.spaceSm,
        ),
        decoration: BoxDecoration(
          color: AppColors.surfaceContainerLowest,
          borderRadius: BorderRadius.circular(AppSpacing.margin),
          border: Border.all(
            color: AppColors.outlineVariant.withValues(alpha: 0.7),
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Order Ref  ',
              style: AppTypography.bodySm.copyWith(color: AppColors.slateBody),
            ),
            Text(
              orderRef,
              style: AppTypography.bodySm.copyWith(
                color: AppColors.slateHeadline,
                fontWeight: FontWeight.w700,
                letterSpacing: 0.5,
              ),
            ),
            const SizedBox(width: AppSpacing.spaceSm),
            const Icon(
              Icons.copy_outlined,
              size: 14,
              color: AppColors.slateHeadline,
            ),
          ],
        ),
      ),
    );
  }
}
