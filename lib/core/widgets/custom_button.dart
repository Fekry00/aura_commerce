import 'package:aura/core/theme/app_colors.dart';
import 'package:aura/core/theme/app_typography.dart';
import 'package:flutter/material.dart';

enum ButtonType { primary, secondary, accentMint }

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final ButtonType type;
  final IconData? icon;
  final double height;
  final bool isLoading;

  const CustomButton({
    super.key,
    required this.text,
    this.onPressed,
    this.type = ButtonType.primary,
    this.icon,
    this.height = 50,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    Color getBackgroundColor() {
      switch (type) {
        case ButtonType.primary:
          return AppColors.primaryContainer;
        case ButtonType.secondary:
          return Colors.transparent;
        case ButtonType.accentMint:
          return AppColors.secondaryContainer;
      }
    }

    Color getTextColor() {
      switch (type) {
        case ButtonType.primary:
          return Colors.white;
        case ButtonType.secondary:
          return AppColors.onSurface;
        case ButtonType.accentMint:
          return AppColors.primary;
      }
    }

    return SizedBox(
      height: height,
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: getBackgroundColor(),
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
            side: type == ButtonType.secondary
                ? const BorderSide(color: AppColors.outlineVariant)
                : BorderSide.none,
          ),
          padding: const EdgeInsets.symmetric(horizontal: 20),
        ),
        onPressed: isLoading ? null : onPressed,
        child: isLoading
            ? const SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: Colors.white,
                ),
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    text,
                    style: AppTypography.bodyLg.copyWith(
                      color: getTextColor(),
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                    ),
                  ),
                  if (icon != null) ...[
                    const SizedBox(width: 8),
                    Icon(icon, color: getTextColor(), size: 18),
                  ],
                ],
              ),
      ),
    );
  }
}
