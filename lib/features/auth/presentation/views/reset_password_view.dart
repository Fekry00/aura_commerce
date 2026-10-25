import 'package:aura/core/theme/app_typography.dart';
import 'package:aura/features/auth/presentation/widgets/reset_password_form.dart';
import 'package:aura/features/auth/presentation/widgets/reset_password_header.dart';
import 'package:flutter/material.dart';

class ResetPasswordView extends StatelessWidget {
  final String otp;

  const ResetPasswordView({super.key, required this.otp});

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
              children: [
                const ResetPasswordHeader(),
                const SizedBox(height: AppSpacing.spaceLg),
                ResetPasswordForm(otp: otp),
                const SizedBox(height: AppSpacing.spaceMd),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
