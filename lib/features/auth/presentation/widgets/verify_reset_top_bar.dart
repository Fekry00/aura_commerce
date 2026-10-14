import 'package:aura/core/theme/app_colors.dart';
import 'package:aura/core/theme/app_typography.dart';
import 'package:flutter/material.dart';

class VerifyResetTopBar extends StatelessWidget {
  const VerifyResetTopBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            IconButton(
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(),
              icon: const Icon(
                Icons.arrow_back,
                size: 20,
                color: AppColors.onSurface,
              ),
              onPressed: () => Navigator.maybePop(context),
            ),
            const SizedBox(width: AppSpacing.spaceSm),
            Text(
              'AURA LUXE',
              style: AppTypography.headlineSm.copyWith(
                color: AppColors.primary,
                fontWeight: FontWeight.w800,
                letterSpacing: 1.2,
                fontSize: 16,
              ),
            ),
          ],
        ),
        Container(
          width: 32,
          height: 32,
          decoration: const BoxDecoration(
            color: AppColors.primary,
            shape: BoxShape.circle,
          ),
          child: const Icon(Icons.person, color: AppColors.onPrimary, size: 18),
        ),
      ],
    );
  }
}
