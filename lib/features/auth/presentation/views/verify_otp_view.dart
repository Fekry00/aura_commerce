import 'package:aura/core/theme/app_typography.dart';
import 'package:aura/features/auth/presentation/widgets/verify_otp_form.dart';
import 'package:aura/features/auth/presentation/widgets/verify_otp_header.dart';
import 'package:flutter/material.dart';

class VerifyOtpView extends StatelessWidget {
  final String email;

  const VerifyOtpView({super.key, required this.email});

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
                VerifyOtpHeader(email: email),
                const SizedBox(height: AppSpacing.spaceLg),
                VerifyOtpForm(email: email),
                const SizedBox(height: AppSpacing.spaceMd),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
