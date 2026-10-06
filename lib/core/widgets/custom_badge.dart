import 'package:aura/core/theme/app_colors.dart';
import 'package:aura/core/theme/app_typography.dart';
import 'package:flutter/material.dart';


class CustomBadge extends StatelessWidget {
  final String text;
  final bool isDark;

  const CustomBadge({
    super.key,
    required this.text,
    this.isDark = true,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: isDark ? AppColors.primaryContainer : AppColors.secondaryContainer.withOpacity(0.3),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        text.toUpperCase(),
        style: AppTypography.labelCaps.copyWith(
          color: isDark ? Colors.white : AppColors.primary,
          fontSize: 9,
          fontWeight: FontWeight.w700,
          letterSpacing: 0.6,
        ),
      ),
    );
  }
}