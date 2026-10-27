import 'package:aura/core/theme/app_typography.dart';
import 'package:aura/features/auth/presentation/widgets/forgot_password_footer.dart';
import 'package:aura/features/auth/presentation/widgets/forgot_password_form.dart';
import 'package:aura/features/auth/presentation/widgets/forgot_password_header.dart';
import 'package:flutter/material.dart';

class ForgotPasswordView extends StatelessWidget {
  const ForgotPasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.margin,
              vertical: 16,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                ForgotPasswordHeader(),
                SizedBox(height: AppSpacing.spaceLg),
                ForgotPasswordForm(),
                SizedBox(height: AppSpacing.spaceXl),
                ForgotPasswordFooter(),
                SizedBox(height: AppSpacing.spaceMd),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
