import 'package:aura/core/routing/routes.dart';
import 'package:aura/core/theme/app_colors.dart';
import 'package:aura/core/theme/app_typography.dart';
import 'package:flutter/material.dart';

/// Pure declarative UI widget for create account footer.
class CreateAccountFooter extends StatelessWidget {
  final VoidCallback? onSignInTap;

  const CreateAccountFooter({super.key, this.onSignInTap});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: onSignInTap ??
            () => Navigator.pushReplacementNamed(context, Routes.signInView),
        child: RichText(
          text: TextSpan(
            text: 'Already a member? ',
            style: AppTypography.bodySm.copyWith(
              color: AppColors.slateBody,
              fontSize: 12,
            ),
            children: [
              TextSpan(
                text: 'Sign In',
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
    );
  }
}
