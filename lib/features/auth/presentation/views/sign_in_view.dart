import 'package:aura/core/theme/app_typography.dart';
import 'package:aura/features/auth/presentation/widgets/sign_in_footer.dart';
import 'package:aura/features/auth/presentation/widgets/sign_in_form.dart';
import 'package:aura/features/auth/presentation/widgets/sign_in_header.dart';
import 'package:flutter/material.dart';

class SignInView extends StatelessWidget {
  const SignInView({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: const Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            padding: EdgeInsets.symmetric(
              horizontal: AppSpacing.margin,
              vertical: 16,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SignInHeader(),
                SizedBox(height: AppSpacing.spaceLg),
                SignInForm(),
                SizedBox(height: AppSpacing.spaceXl),
                SignInFooter(),
                SizedBox(height: AppSpacing.spaceMd),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
