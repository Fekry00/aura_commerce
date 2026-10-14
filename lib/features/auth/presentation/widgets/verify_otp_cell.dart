import 'package:aura/core/theme/app_colors.dart';
import 'package:aura/core/theme/app_typography.dart';
import 'package:flutter/material.dart';

class VerifyOtpCell extends StatelessWidget {
  final String? digit;
  final bool isActive;

  const VerifyOtpCell({super.key, this.digit, this.isActive = false});

  @override
  Widget build(BuildContext context) {
    final isFilled = digit != null && digit!.isNotEmpty;

    return Container(
      width: 46,
      height: 56,
      decoration: BoxDecoration(
        color: isActive ? AppColors.surfaceContainerLowest : AppColors.surfaceContainerLow,
        borderRadius: BorderRadius.circular(AppSpacing.spaceSm + 2),
        border: Border.all(color: isActive ? AppColors.primary : Colors.transparent, width: 1.5),
        boxShadow: isActive ? [BoxShadow(color: AppColors.primary.withValues(alpha: 0.1), blurRadius: 6)] : null,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (isFilled) ...[
            Text(digit!, style: AppTypography.headlineMd.copyWith(color: AppColors.primary, fontWeight: FontWeight.w700)),
            const SizedBox(height: 2),
            Container(width: 8, height: 2, decoration: BoxDecoration(color: AppColors.secondary, borderRadius: BorderRadius.circular(1))),
          ] else if (isActive)
            Container(width: 8, height: 8, decoration: const BoxDecoration(color: AppColors.primary, shape: BoxShape.circle))
          else
            Container(width: 10, height: 2, decoration: BoxDecoration(color: AppColors.outlineVariant, borderRadius: BorderRadius.circular(1))),
        ],
      ),
    );
  }
}
