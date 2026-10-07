import 'package:aura/core/theme/app_colors.dart';
import 'package:aura/core/theme/app_typography.dart';
import 'package:flutter/material.dart';

class AuthTextFormField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final IconData? prefixIcon;
  final Widget? suffixWidget;
  final bool obscureText;
  final TextInputType keyboardType;
  final ValueChanged<String>? onChanged;
  final String? Function(String?)? validator;

  const AuthTextFormField({
    super.key,
    required this.controller,
    required this.hintText,
    this.prefixIcon,
    this.suffixWidget,
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
    this.onChanged,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      keyboardType: keyboardType,
      onChanged: onChanged,
      validator: validator,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      style: AppTypography.bodySm.copyWith(
        fontWeight: FontWeight.w600,
        color: const Color(0xFF111827),
      ),
      decoration: InputDecoration(
        filled: true,
        fillColor: const Color(0xFFF3F4F6),
        hintText: hintText,
        hintStyle: AppTypography.bodySm.copyWith(
          color: const Color(0xFF9CA3AF),
          fontSize: 13,
        ),
        prefixIcon: prefixIcon != null
            ? Icon(prefixIcon, size: 18, color: const Color(0xFF9CA3AF))
            : null,
        suffixIcon: suffixWidget != null
            ? Padding(
                padding: const EdgeInsets.only(right: 8),
                child: suffixWidget,
              )
            : null,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 14,
          vertical: 12,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Color(0xFF0B3B2C), width: 1.2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: AppColors.error, width: 1.0),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: AppColors.error, width: 1.2),
        ),
        errorStyle: const TextStyle(
          color: AppColors.error,
          fontSize: 11,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
