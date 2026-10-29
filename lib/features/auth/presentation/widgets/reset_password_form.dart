import 'package:aura/core/routing/routes.dart';
import 'package:aura/core/theme/app_typography.dart';
import 'package:aura/core/utils/functions/custom_snack_bar.dart';
import 'package:aura/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:aura/features/auth/presentation/cubit/auth_state.dart';
import 'package:aura/features/auth/presentation/utils/auth_validation_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'auth_field_header.dart';
import 'auth_text_form_field.dart';
import 'reset_password_requirements.dart';
import 'reset_password_strength_meter.dart';
import 'reset_password_submit_button.dart';

/// Pure declarative UI widget for Reset Password form.
class ResetPasswordForm extends StatefulWidget {
  final String otp;

  const ResetPasswordForm({
    super.key,
    required this.otp,
  });

  @override
  State<ResetPasswordForm> createState() => _ResetPasswordFormState();
}

class _ResetPasswordFormState extends State<ResetPasswordForm> {
  final _formKey = GlobalKey<FormState>();

  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  bool _obscurePassword = true;
  bool _obscureConfirm = true;

  @override
  void dispose() {
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _onSubmit() {
    final isValid = _formKey.currentState?.validate() ?? false;
    context.read<AuthCubit>().resetPassword(
          otp: widget.otp,
          newPassword: _passwordController.text,
          confirmPassword: _confirmPasswordController.text,
          isFormValid: isValid,
        );
  }

  String? _validatePassword(String? val) {
    if (val == null || val.isEmpty) return 'Password is required';
    if (val.length < 8) return 'Password must be at least 8 characters';
    return null;
  }

  String? _validateConfirmPassword(String? val) {
    if (val == null || val.isEmpty) return 'Please confirm your password';
    if (val != _passwordController.text) return 'Passwords do not match';
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final strength =
        AuthValidationHelper.calculatePasswordStrength(_passwordController.text);

    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthErrorState) {
          showCustomSnackBar(
            context,
            message: state.message,
            type: SnackBarType.error,
          );
        } else if (state is AuthPasswordResetSuccessState) {
          showCustomSnackBar(
            context,
            message: 'Password reset successfully. Please sign in.',
            type: SnackBarType.success,
          );
          Navigator.pushNamedAndRemoveUntil(
            context,
            Routes.signInView,
            (route) => false,
          );
        }
      },
      builder: (context, state) {
        final isLoading = state is AuthLoadingState;

        return Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const AuthFieldHeader(
                label: 'NEW PASSWORD',
                isRequired: true,
                trailingText: 'Min 8 chars',
              ),
              const SizedBox(height: AppSpacing.spaceXs),
              AuthTextFormField(
                controller: _passwordController,
                obscureText: _obscurePassword,
                hintText: 'Enter new password',
                prefixIcon: Icons.lock_outline_rounded,
                onChanged: (_) => setState(() {}),
                validator: _validatePassword,
                suffixWidget: IconButton(
                  icon: Icon(
                    _obscurePassword
                        ? Icons.visibility_off_outlined
                        : Icons.visibility_outlined,
                    size: 18,
                    color: const Color(0xFF9CA3AF),
                  ),
                  onPressed: () =>
                      setState(() => _obscurePassword = !_obscurePassword),
                ),
              ),
              if (_passwordController.text.isNotEmpty) ...[
                const SizedBox(height: AppSpacing.spaceSm),
                ResetPasswordStrengthMeter(strength: strength),
              ],
              const SizedBox(height: AppSpacing.spaceMd),

              const AuthFieldHeader(
                label: 'CONFIRM PASSWORD',
                isRequired: true,
                trailingText: 'Must Match',
              ),
              const SizedBox(height: AppSpacing.spaceXs),
              AuthTextFormField(
                controller: _confirmPasswordController,
                obscureText: _obscureConfirm,
                hintText: 'Re-enter new password',
                prefixIcon: Icons.lock_outline_rounded,
                onChanged: (_) => setState(() {}),
                validator: _validateConfirmPassword,
                suffixWidget: IconButton(
                  icon: Icon(
                    _obscureConfirm
                        ? Icons.visibility_off_outlined
                        : Icons.visibility_outlined,
                    size: 18,
                    color: const Color(0xFF9CA3AF),
                  ),
                  onPressed: () =>
                      setState(() => _obscureConfirm = !_obscureConfirm),
                ),
              ),
              const SizedBox(height: AppSpacing.spaceLg),

              ResetPasswordRequirements(
                password: _passwordController.text,
              ),
              const SizedBox(height: AppSpacing.spaceXl),

              ResetPasswordSubmitButton(
                isLoading: isLoading,
                onPressed: _onSubmit,
              ),
            ],
          ),
        );
      },
    );
  }
}
