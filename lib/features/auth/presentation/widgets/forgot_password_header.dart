import 'package:aura/core/theme/app_colors.dart';
import 'package:aura/core/theme/app_typography.dart';
import 'package:flutter/material.dart';

class ForgotPasswordHeader extends StatelessWidget {
  const ForgotPasswordHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
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
                    color: Color(0xFF111827),
                  ),
                  onPressed: () => Navigator.maybePop(context),
                ),
                const SizedBox(width: AppSpacing.spaceSm + 2),
                Container(
                  width: 10,
                  height: 10,
                  decoration: const BoxDecoration(
                    color: Color(0xFF0B3B2C),
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: AppSpacing.spaceSm),
                Text(
                  'AURA LUXE',
                  style: AppTypography.headlineSm.copyWith(
                    fontWeight: FontWeight.w900,
                    letterSpacing: 1.5,
                    fontSize: 16,
                    color: const Color(0xFF0B3B2C),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Text(
                  'RECOVERY',
                  style: AppTypography.labelCaps.copyWith(
                    color: const Color(0xFF374151),
                    fontWeight: FontWeight.w700,
                    fontSize: 11,
                    letterSpacing: 0.8,
                  ),
                ),
                const SizedBox(width: AppSpacing.spaceSm + 2),
                Container(
                  width: 32,
                  height: 32,
                  decoration: const BoxDecoration(
                    color: Color(0xFF0B3B2C),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.key_outlined,
                    color: Colors.white,
                    size: 16,
                  ),
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.spaceLg),
        Row(
          children: [
            Container(
              width: 6,
              height: 6,
              decoration: const BoxDecoration(
                color: Color(0xFF0B3B2C),
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(width: 6),
            Text(
              'ACCOUNT ACCESS',
              style: AppTypography.labelCaps.copyWith(
                color: const Color(0xFF0B3B2C),
                fontWeight: FontWeight.w800,
                fontSize: 10,
                letterSpacing: 0.8,
              ),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.spaceSm),
        Text(
          'Forgot Password?',
          style: AppTypography.headlineLg.copyWith(
            fontWeight: FontWeight.w800,
            fontSize: 26,
            color: const Color(0xFF111827),
          ),
        ),
        const SizedBox(height: 6),
        Text(
          'Enter the email associated with your account. We\'ll send you a secure reset code.',
          style: AppTypography.bodySm.copyWith(
            color: AppColors.slateBody,
            height: 1.4,
            fontSize: 12,
          ),
        ),
      ],
    );
  }
}
