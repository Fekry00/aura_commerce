import 'package:aura/core/theme/app_typography.dart';
import 'package:aura/core/utils/functions/custom_snack_bar.dart';
import 'package:flutter/material.dart';
 

class SignInActionsRow extends StatelessWidget {
  final bool rememberDevice;
  final ValueChanged<bool> onRememberChanged;

  const SignInActionsRow({
    super.key,
    required this.rememberDevice,
    required this.onRememberChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: () => onRememberChanged(!rememberDevice),
          child: Row(
            children: [
              Container(
                width: AppSpacing.spaceMd,
                height: AppSpacing.spaceMd,
                decoration: BoxDecoration(
                  color: rememberDevice ? const Color(0xFF0B3B2C) : Colors.transparent,
                  borderRadius: BorderRadius.circular(4),
                  border: Border.all(color: const Color(0xFF0B3B2C), width: 1.5),
                ),
                child: rememberDevice
                    ? const Icon(Icons.check, size: 12, color: Colors.white)
                    : null,
              ),
              const SizedBox(width: AppSpacing.spaceSm),
              Text(
                'Remember device',
                style: AppTypography.bodySm.copyWith(
                  color: const Color(0xFF374151),
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
        GestureDetector(
          onTap: () {
            showCustomSnackBar(
              context,
              message: 'Reset instructions sent to concierge dispatch.',
              type: SnackBarType.info,
            );
          },
          child: Text(
            'Forgot Password?',
            style: AppTypography.bodySm.copyWith(
              color: const Color(0xFF111827),
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }
}