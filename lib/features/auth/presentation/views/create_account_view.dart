import 'package:aura/core/routing/routes.dart';
import 'package:aura/core/theme/app_colors.dart';
import 'package:aura/core/theme/app_typography.dart';
import 'package:aura/features/auth/presentation/widgets/auth_top_bar.dart';
import 'package:aura/features/auth/presentation/widgets/create_account_form.dart';
import 'package:aura/features/auth/presentation/widgets/create_account_header.dart';
import 'package:flutter/material.dart';

class CreateAccountView extends StatelessWidget {
  const CreateAccountView({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.margin, vertical: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const AuthTopBar(),
                const SizedBox(height: AppSpacing.spaceLg),
                const CreateAccountHeader(),
                const SizedBox(height: AppSpacing.spaceLg),
                const CreateAccountForm(),
                const SizedBox(height: AppSpacing.spaceMd),
      
                Center(
                  child: GestureDetector(
                    onTap: () {
                       Navigator.pushReplacementNamed(context, Routes.signInView);
                    },
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
                ),
                const SizedBox(height: AppSpacing.spaceLg),
              ],
            ),
          ),
        ),
      ),
    );
  }
}