import 'package:aura/core/routing/routes.dart';
import 'package:aura/core/theme/app_typography.dart';
import 'package:aura/core/utils/functions/custom_snack_bar.dart';
import 'package:aura/features/auth/presentation/controllers/reset_password_form_controller.dart';
import 'package:aura/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:aura/features/auth/presentation/cubit/auth_state.dart';
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
  final ResetPasswordFormController? controller;

  const ResetPasswordForm({
    super.key,
    required this.otp,
    this.controller,
  });

  @override
  State<ResetPasswordForm> createState() => _ResetPasswordFormState();
}

class _ResetPasswordFormState extends State<ResetPasswordForm> {
  late final ResetPasswordFormController _controller;
  late final bool _internalController;

  @override
  void initState() {
    super.initState();
    _internalController = widget.controller == null;
    _controller = widget.controller ?? ResetPasswordFormController();
  }

  @override
  void dispose() {
    if (_internalController) {
      _controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
          key: _controller.formKey,
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
                controller: _controller.passwordController,
                obscureText: _controller.obscurePassword,
                hintText: 'Enter new password',
                prefixIcon: Icons.lock_outline_rounded,
                onChanged: (_) => setState(() {}),
                validator: _controller.validatePassword,
                suffixWidget: IconButton(
                  icon: Icon(
                    _controller.obscurePassword
                        ? Icons.visibility_off_outlined
                        : Icons.visibility_outlined,
                    size: 18,
                    color: const Color(0xFF9CA3AF),
                  ),
                  onPressed: () =>
                      setState(() => _controller.toggleObscurePassword()),
                ),
              ),
              if (_controller.passwordController.text.isNotEmpty) ...[
                const SizedBox(height: AppSpacing.spaceSm),
                ResetPasswordStrengthMeter(strength: _controller.strength),
              ],
              const SizedBox(height: AppSpacing.spaceMd),

              const AuthFieldHeader(
                label: 'CONFIRM PASSWORD',
                isRequired: true,
                trailingText: 'Must Match',
              ),
              const SizedBox(height: AppSpacing.spaceXs),
              AuthTextFormField(
                controller: _controller.confirmPasswordController,
                obscureText: _controller.obscureConfirm,
                hintText: 'Re-enter new password',
                prefixIcon: Icons.lock_outline_rounded,
                onChanged: (_) => setState(() {}),
                validator: _controller.validateConfirmPassword,
                suffixWidget: IconButton(
                  icon: Icon(
                    _controller.obscureConfirm
                        ? Icons.visibility_off_outlined
                        : Icons.visibility_outlined,
                    size: 18,
                    color: const Color(0xFF9CA3AF),
                  ),
                  onPressed: () =>
                      setState(() => _controller.toggleObscureConfirm()),
                ),
              ),
              const SizedBox(height: AppSpacing.spaceLg),

              ResetPasswordRequirements(
                password: _controller.passwordController.text,
              ),
              const SizedBox(height: AppSpacing.spaceXl),

              ResetPasswordSubmitButton(
                isLoading: isLoading,
                onPressed: () => _controller.onSubmit(context, otp: widget.otp),
              ),
            ],
          ),
        );
      },
    );
  }
}
