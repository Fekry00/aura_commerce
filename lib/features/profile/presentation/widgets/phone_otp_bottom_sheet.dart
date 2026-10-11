import 'package:aura/core/theme/app_colors.dart';
import 'package:aura/core/theme/app_typography.dart';
import 'package:aura/core/utils/functions/custom_snack_bar.dart';
import 'package:flutter/material.dart';

class PhoneOtpBottomSheet extends StatelessWidget {
  final String phoneNumber;
  final ValueChanged<String>? onVerified;

  const PhoneOtpBottomSheet({super.key, this.phoneNumber = '+20 100 000 0000', this.onVerified});

  static Future<void> show(BuildContext context, {String phoneNumber = '+20 100 000 0000', ValueChanged<String>? onVerified}) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => PhoneOtpBottomSheet(phoneNumber: phoneNumber, onVerified: onVerified),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.margin),
      decoration: const BoxDecoration(
        color: AppColors.surfaceContainerLowest,
        borderRadius: BorderRadius.vertical(top: Radius.circular(AppSpacing.margin)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(width: AppSpacing.spaceXl, height: AppSpacing.spaceXs, decoration: BoxDecoration(color: AppColors.outlineVariant, borderRadius: BorderRadius.circular(AppSpacing.spaceXs))),
          const SizedBox(height: AppSpacing.spaceMd),
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(AppSpacing.spaceSm),
                decoration: BoxDecoration(color: AppColors.secondaryContainer.withValues(alpha: 0.2), shape: BoxShape.circle),
                child: const Icon(Icons.verified_user, size: AppSpacing.spaceMd, color: AppColors.secondary),
              ),
              const SizedBox(width: AppSpacing.spaceSm),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('SECURITY PROTOCOL', style: AppTypography.labelCaps.copyWith(color: AppColors.secondary, letterSpacing: 1.0)),
                    Text('Verify New Phone Number', style: AppTypography.headlineSm.copyWith(fontWeight: FontWeight.w700, fontSize: 16)),
                  ],
                ),
              ),
              IconButton(onPressed: () => Navigator.pop(context), icon: const Icon(Icons.close, color: AppColors.outline)),
            ],
          ),
          const SizedBox(height: AppSpacing.spaceSm),
          Container(
            padding: const EdgeInsets.all(AppSpacing.spaceSm),
            decoration: BoxDecoration(color: AppColors.surfaceContainerLow, borderRadius: BorderRadius.circular(AppSpacing.spaceSm)),
            child: Text('A 6-digit cryptographic code has been dispatched via SMS to $phoneNumber.', style: AppTypography.bodySm.copyWith(color: AppColors.slateBody)),
          ),
          const SizedBox(height: AppSpacing.spaceMd),
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: ['4', '8', '2', '', '', ''].map(_buildDigitBox).toList()),
          const SizedBox(height: AppSpacing.spaceSm),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(children: [
                const Icon(Icons.schedule, size: AppSpacing.spaceSm + AppSpacing.spaceXs, color: AppColors.outline),
                const SizedBox(width: AppSpacing.spaceXs / 2),
                Text('Resend Code in 00:48', style: AppTypography.labelSm.copyWith(color: AppColors.slateBody, fontSize: 11)),
              ]),
              Text('Resend SMS', style: AppTypography.labelSm.copyWith(color: AppColors.secondary, fontWeight: FontWeight.w600)),
            ],
          ),
          const SizedBox(height: AppSpacing.spaceMd),
          InkWell(
            onTap: () {
              Navigator.pop(context);
              onVerified?.call(phoneNumber);
              showCustomSnackBar(context, message: 'Handset verified • POST /phone/verify-otp', type: SnackBarType.success);
            },
            borderRadius: BorderRadius.circular(AppSpacing.margin),
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: AppSpacing.spaceMd - 2),
              decoration: BoxDecoration(color: AppColors.primaryContainer, borderRadius: BorderRadius.circular(AppSpacing.margin)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.lock_open_rounded, size: AppSpacing.spaceMd, color: AppColors.secondaryContainer),
                  const SizedBox(width: AppSpacing.spaceSm),
                  Text('Verify & Update Phone', style: AppTypography.bodyMd.copyWith(color: AppColors.onPrimary, fontWeight: FontWeight.w700)),
                ],
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.spaceSm),
        ],
      ),
    );
  }

  Widget _buildDigitBox(String digit) {
    final bool isFilled = digit.isNotEmpty;
    return Container(
      width: AppSpacing.spaceXl + AppSpacing.spaceXs,
      height: AppSpacing.spaceXl + AppSpacing.spaceSm,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: isFilled ? AppColors.surfaceContainerLow : AppColors.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(AppSpacing.spaceSm),
        border: Border.all(color: isFilled ? Colors.transparent : AppColors.primaryContainer, width: isFilled ? 1.0 : 2.0),
      ),
      child: Text(digit, style: AppTypography.headlineMd.copyWith(fontWeight: FontWeight.w700)),
    );
  }
}
