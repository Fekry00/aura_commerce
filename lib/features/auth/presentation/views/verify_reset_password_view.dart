import 'package:aura/core/routing/routes.dart';
import 'package:aura/core/theme/app_colors.dart';
import 'package:aura/core/theme/app_typography.dart';
import 'package:aura/core/utils/functions/custom_snack_bar.dart';
import 'package:aura/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:aura/features/auth/presentation/cubit/auth_state.dart';
import 'package:aura/features/auth/presentation/widgets/verify_reset_password_card.dart';
import 'package:aura/features/auth/presentation/widgets/verify_reset_top_bar.dart';
import 'package:aura/features/auth/presentation/widgets/verify_security_footer.dart';
import 'package:aura/features/auth/presentation/widgets/verify_security_header.dart';
import 'package:aura/features/auth/presentation/widgets/verify_vault_status_strip.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class VerifyResetPasswordView extends StatelessWidget {
  const VerifyResetPasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthInfoMessageState) {
          showCustomSnackBar(
            context,
            message: state.message,
            type: SnackBarType.info,
          );
        } else if (state is AuthErrorState) {
          showCustomSnackBar(
            context,
            message: state.message,
            type: SnackBarType.error,
          );
        } else if (state is AuthPasswordResetSuccessState) {
          showCustomSnackBar(
            context,
            message: state.message,
            type: SnackBarType.success,
          );
          Navigator.pushReplacementNamed(context, Routes.signInView);
        }
      },
      child: Scaffold(
        backgroundColor: AppColors.surface,
        body: SafeArea(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.gutter,
              vertical: AppSpacing.spaceSm,
            ),
            child: Column(
              children: [
                const VerifyResetTopBar(),
                const SizedBox(height: AppSpacing.spaceSm),
                VerifyVaultStatusStrip(
                  onConciergeTap: () =>
                      context.read<AuthCubit>().connectConcierge(),
                ),
                const SizedBox(height: AppSpacing.spaceSm),
                VerifySecurityHeader(
                  onChangeEmail: () => Navigator.pushReplacementNamed(
                      context, Routes.signInView),
                ),
                const SizedBox(height: AppSpacing.spaceMd),
                const VerifyResetPasswordCard(),
                const SizedBox(height: AppSpacing.spaceLg),
                VerifySecurityFooter(
                  onLockAccount: () =>
                      context.read<AuthCubit>().lockAccount(),
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
