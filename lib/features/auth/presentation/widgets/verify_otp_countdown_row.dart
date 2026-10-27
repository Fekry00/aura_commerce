import 'package:aura/core/theme/app_colors.dart';
import 'package:aura/core/theme/app_typography.dart';
import 'package:flutter/material.dart';

class VerifyOtpCountdownRow extends StatelessWidget {
  final bool canResend;
  final String formattedTimer;
  final int secondsRemaining;
  final VoidCallback onResend;

  const VerifyOtpCountdownRow({
    super.key,
    required this.canResend,
    required this.formattedTimer,
    required this.secondsRemaining,
    required this.onResend,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: onResend,
          child: Text(
            canResend ? 'Resend code now' : 'Resend in $formattedTimer',
            style: AppTypography.labelSm.copyWith(
              color: canResend
                  ? const Color(0xFF0B3B2C)
                  : const Color(0xFF9CA3AF),
              fontWeight: canResend ? FontWeight.w700 : FontWeight.w500,
            ),
          ),
        ),
        Text(
          'Expires in $formattedTimer',
          style: AppTypography.labelSm.copyWith(
            color: secondsRemaining < 30
                ? AppColors.error
                : AppColors.slateBody,
          ),
        ),
      ],
    );
  }
}
