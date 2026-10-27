import 'package:aura/core/theme/app_typography.dart';
import 'package:aura/features/auth/presentation/widgets/auth_top_bar.dart';
import 'package:aura/features/auth/presentation/widgets/create_account_footer.dart';
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
              children: const [
                AuthTopBar(),
                SizedBox(height: AppSpacing.spaceLg),
                CreateAccountHeader(),
                SizedBox(height: AppSpacing.spaceLg),
                CreateAccountForm(),
                SizedBox(height: AppSpacing.spaceMd),
                CreateAccountFooter(),
                SizedBox(height: AppSpacing.spaceLg),
              ],
            ),
          ),
        ),
      ),
    );
  }
}