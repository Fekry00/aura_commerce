import 'package:aura/core/theme/app_typography.dart';
import 'package:aura/features/auth/presentation/widgets/sign_in_footer.dart';
import 'package:aura/features/auth/presentation/widgets/sign_in_form.dart';
import 'package:aura/features/auth/presentation/widgets/sign_in_header.dart';
import 'package:flutter/material.dart';

class SignInView extends StatelessWidget {
  const SignInView({super.key, this.initialEmail});

  final String? initialEmail;

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
                const SignInHeader(),
                const SizedBox(height: AppSpacing.spaceLg),
                SignInForm(initialEmail: initialEmail),
                const SizedBox(height: AppSpacing.spaceXl),
                const SignInFooter(),
                const SizedBox(height: AppSpacing.spaceMd),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
