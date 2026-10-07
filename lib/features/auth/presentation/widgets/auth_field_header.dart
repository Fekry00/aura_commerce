import 'package:aura/core/theme/app_colors.dart';
import 'package:aura/core/theme/app_typography.dart';
import 'package:flutter/material.dart';


class AuthFieldHeader extends StatelessWidget {
  final String label;
  final bool isRequired;
  final String? trailingText;
  final Color? trailingColor;

  const AuthFieldHeader({
    super.key,
    required this.label,
    this.isRequired = false,
    this.trailingText,
    this.trailingColor,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Text(
              label,
              style: AppTypography.labelCaps.copyWith(
                color: const Color(0xFF4B5563),
                fontSize: 10,
                fontWeight: FontWeight.w700,
                letterSpacing: 0.5,
              ),
            ),
            if (isRequired)
              const Text(
                ' *',
                style: TextStyle(
                  color: AppColors.error,
                  fontWeight: FontWeight.bold,
                  fontSize: 11,
                ),
              ),
          ],
        ),
        if (trailingText != null && trailingText!.isNotEmpty)
          Text(
            trailingText!,
            style: AppTypography.labelCaps.copyWith(
              color: trailingColor ?? const Color(0xFF6B7280),
              fontSize: 9,
              fontWeight: FontWeight.w700,
            ),
          ),
      ],
    );
  }
}