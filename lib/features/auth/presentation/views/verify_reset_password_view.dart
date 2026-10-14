import 'package:aura/core/routing/routes.dart';
import 'package:aura/core/theme/app_colors.dart';
import 'package:aura/core/theme/app_typography.dart';
import 'package:aura/core/utils/functions/custom_snack_bar.dart';
import 'package:aura/features/auth/presentation/widgets/verify_keycode_inputs.dart';
import 'package:aura/features/auth/presentation/widgets/verify_new_password_section.dart';
import 'package:aura/features/auth/presentation/widgets/verify_reset_submit_button.dart';
import 'package:aura/features/auth/presentation/widgets/verify_reset_top_bar.dart';
import 'package:aura/features/auth/presentation/widgets/verify_security_footer.dart';
import 'package:aura/features/auth/presentation/widgets/verify_security_header.dart';
import 'package:aura/features/auth/presentation/widgets/verify_vault_status_strip.dart';
import 'package:flutter/material.dart';

class VerifyResetPasswordView extends StatefulWidget {
  const VerifyResetPasswordView({super.key});

  @override
  State<VerifyResetPasswordView> createState() => _VerifyResetPasswordViewState();
}

class _VerifyResetPasswordViewState extends State<VerifyResetPasswordView> {
  final _otpController = TextEditingController(text: '8429');
  final _passwordController = TextEditingController(text: 'Atelier2025#');
  final _confirmPasswordController = TextEditingController(text: 'Atelier2025#');

  @override
  void dispose() {
    _otpController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _onSubmit() {
    if (_otpController.text.length < 6) {
      showCustomSnackBar(context, message: 'Please enter all 6 digits of the keycode.', type: SnackBarType.error);
    } else if (_passwordController.text.length < 8) {
      showCustomSnackBar(context, message: 'Password must be at least 8 characters.', type: SnackBarType.error);
    } else if (_passwordController.text != _confirmPasswordController.text) {
      showCustomSnackBar(context, message: 'Passwords do not match.', type: SnackBarType.error);
    } else {
      showCustomSnackBar(context, message: 'Password reset successfully! Welcome to Atelier Vault.', type: SnackBarType.success);
      Navigator.pushReplacementNamed(context, Routes.signInView);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surface,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.gutter, vertical: AppSpacing.spaceSm),
          child: Column(
            children: [
              const VerifyResetTopBar(),
              const SizedBox(height: AppSpacing.spaceSm),
              VerifyVaultStatusStrip(onConciergeTap: () => showCustomSnackBar(context, message: 'Connecting to Concierge...', type: SnackBarType.info)),
              const SizedBox(height: AppSpacing.spaceSm),
              VerifySecurityHeader(onChangeEmail: () => Navigator.pushReplacementNamed(context, Routes.signInView)),
              const SizedBox(height: AppSpacing.spaceMd),
              _buildInteractionCard(),
              const SizedBox(height: AppSpacing.spaceLg),
              VerifySecurityFooter(onLockAccount: () => showCustomSnackBar(context, message: 'Account locked for security.', type: SnackBarType.error)),
              const SizedBox(height: AppSpacing.spaceLg),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInteractionCard() {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.gutter),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(AppSpacing.spaceMd),
        border: Border.all(color: AppColors.outlineVariant.withValues(alpha: 0.5)),
      ),
      child: Column(
        children: [
          VerifyKeycodeInputs(controller: _otpController),
          const SizedBox(height: AppSpacing.spaceMd),
          Container(height: 1, color: AppColors.surfaceContainer),
          const SizedBox(height: AppSpacing.spaceMd),
          VerifyNewPasswordSection(passwordController: _passwordController, confirmPasswordController: _confirmPasswordController),
          const SizedBox(height: AppSpacing.spaceLg),
          VerifyResetSubmitButton(onPressed: _onSubmit),
        ],
      ),
    );
  }
}
