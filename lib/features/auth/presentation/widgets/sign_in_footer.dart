import 'package:aura/core/routing/routes.dart';
import 'package:aura/core/theme/app_colors.dart';
import 'package:aura/core/theme/app_typography.dart';
import 'package:flutter/material.dart';


class SignInFooter extends StatelessWidget {
  const SignInFooter({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
          decoration: BoxDecoration(
            color: const Color(0xFFF9FAFB),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: const Color(0xFFF3F4F6)),
          ),
          child: Row(
            children: [
              Container(
                width: 32,
                height: 32,
                decoration: const BoxDecoration(
                  color: Color(0xFF0B3B2C),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.shield_outlined, color: Colors.white, size: 16),
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'ATELIER MEMBERSHIP',
                    style: AppTypography.labelCaps.copyWith(
                      color: const Color(0xFF0B3B2C),
                      fontWeight: FontWeight.w800,
                      fontSize: 9,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    'Encrypted access & complimentary white-glove delivery',
                    style: AppTypography.bodySm.copyWith(
                      color: const Color(0xFF4B5563),
                      fontSize: 11,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: AppSpacing.spaceLg),

        GestureDetector(
          onTap: () {
            Navigator.pushReplacementNamed(context, Routes.createAccountView);
          },
          child: RichText(
            text: TextSpan(
              text: "Don't have an Atelier account? ",
              style: AppTypography.bodySm.copyWith(
                color: AppColors.slateBody,
                fontSize: 12,
              ),
              children: [
                TextSpan(
                  text: 'Create Account',
                  style: AppTypography.bodySm.copyWith(
                    color: const Color(0xFF111827),
                    fontWeight: FontWeight.w700,
                    decoration: TextDecoration.underline,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: AppSpacing.spaceMd),

        Text(
          '🔒 256-BIT SSL ENCRYPTED & PRIVATE CONCIERGE PROTECTED',
          style: AppTypography.labelCaps.copyWith(
            color: const Color(0xFF9CA3AF),
            fontSize: 9,
            letterSpacing: 0.5,
          ),
        ),
      ],
    );
  }
}