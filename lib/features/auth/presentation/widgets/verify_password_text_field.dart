import 'package:aura/core/theme/app_colors.dart';
import 'package:aura/core/theme/app_typography.dart';
import 'package:flutter/material.dart';

class VerifyPasswordTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  final bool obscure;
  final Widget suffix;

  const VerifyPasswordTextField({
    super.key,
    required this.controller,
    required this.hint,
    required this.obscure,
    required this.suffix,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48,
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.gutter),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerLow,
        borderRadius: BorderRadius.circular(AppSpacing.spaceSm + 2),
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: controller,
              obscureText: obscure,
              style: AppTypography.bodyMd.copyWith(color: AppColors.onSurface),
              decoration: InputDecoration(
                hintText: hint,
                border: InputBorder.none,
                isDense: true,
                contentPadding: EdgeInsets.zero,
              ),
            ),
          ),
          suffix,
        ],
      ),
    );
  }
}
