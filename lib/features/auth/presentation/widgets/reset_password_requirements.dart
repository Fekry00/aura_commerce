import 'package:aura/core/theme/app_colors.dart';
import 'package:aura/core/theme/app_typography.dart';
import 'package:flutter/material.dart';

class ResetPasswordRequirements extends StatelessWidget {
  final String password;

  const ResetPasswordRequirements({super.key, required this.password});

  @override
  Widget build(BuildContext context) {
    final checks = [
      (label: 'At least 8 characters', met: password.length >= 8),
      (label: 'One uppercase letter', met: password.contains(RegExp(r'[A-Z]'))),
      (label: 'One number', met: password.contains(RegExp(r'[0-9]'))),
      (label: 'One special character', met: password.contains(RegExp(r'[!@#\$&*~%^()]'))),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'PASSWORD REQUIREMENTS',
          style: AppTypography.labelCaps.copyWith(
            color: const Color(0xFF6B7280),
            letterSpacing: 0.8,
            fontSize: 10,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: AppSpacing.spaceSm),
        ...checks.map(
          (check) => Padding(
            padding: const EdgeInsets.only(bottom: 6),
            child: Row(
              children: [
                Icon(
                  check.met ? Icons.check_circle_rounded : Icons.radio_button_unchecked_rounded,
                  size: 16,
                  color: check.met ? const Color(0xFF0B3B2C) : const Color(0xFF9CA3AF),
                ),
                const SizedBox(width: AppSpacing.spaceXs),
                Text(
                  check.label,
                  style: AppTypography.bodySm.copyWith(
                    color: check.met ? const Color(0xFF111827) : AppColors.slateBody,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
