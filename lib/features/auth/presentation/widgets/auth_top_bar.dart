import 'package:aura/core/theme/app_typography.dart';
import 'package:flutter/material.dart';

class AuthTopBar extends StatelessWidget {
  const AuthTopBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
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
                  'CREATE ACCOUNT',
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
                    Icons.person_outline,
                    color: Colors.white,
                    size: 18,
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
