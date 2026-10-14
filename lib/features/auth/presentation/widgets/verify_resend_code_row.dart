import 'package:aura/core/theme/app_colors.dart';
import 'package:aura/core/theme/app_typography.dart';
import 'package:flutter/material.dart';

class VerifyResendCodeRow extends StatelessWidget {
  final int secondsRemaining;
  final String formattedTimer;
  final VoidCallback? onResendCode;
  final VoidCallback? onRequestSms;

  const VerifyResendCodeRow({
    super.key,
    required this.secondsRemaining,
    required this.formattedTimer,
    this.onResendCode,
    this.onRequestSms,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: secondsRemaining == 0 ? onResendCode : null,
          child: Text(
            secondsRemaining == 0 ? 'Resend code now' : 'Resend code in $formattedTimer',
            style: AppTypography.labelSm.copyWith(
              color: secondsRemaining == 0 ? AppColors.secondary : AppColors.outline,
              fontWeight: secondsRemaining == 0 ? FontWeight.w700 : FontWeight.w400,
            ),
          ),
        ),
        GestureDetector(
          onTap: onRequestSms,
          child: Text(
            'Request code via SMS',
            style: AppTypography.labelSm.copyWith(
              color: AppColors.secondary,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }
}
