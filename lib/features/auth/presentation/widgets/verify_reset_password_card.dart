import 'package:aura/core/theme/app_colors.dart';
import 'package:aura/core/theme/app_typography.dart';
import 'package:aura/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:aura/features/auth/presentation/cubit/auth_state.dart';
import 'package:aura/features/auth/presentation/widgets/verify_keycode_inputs.dart';
import 'package:aura/features/auth/presentation/widgets/verify_new_password_section.dart';
import 'package:aura/features/auth/presentation/widgets/verify_reset_submit_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Pure declarative UI widget for reset password interactive card.
class VerifyResetPasswordCard extends StatefulWidget {
  const VerifyResetPasswordCard({super.key});

  @override
  State<VerifyResetPasswordCard> createState() =>
      _VerifyResetPasswordCardState();
}

class _VerifyResetPasswordCardState extends State<VerifyResetPasswordCard> {
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
    context.read<AuthCubit>().resetPassword(
          otp: _otpController.text.trim(),
          newPassword: _passwordController.text,
          confirmPassword: _confirmPasswordController.text,
        );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        final isLoading = state is AuthLoadingState;
        return Container(
          padding: const EdgeInsets.all(AppSpacing.gutter),
          decoration: BoxDecoration(
            color: AppColors.surfaceContainerLowest,
            borderRadius: BorderRadius.circular(AppSpacing.spaceMd),
            border: Border.all(
              color: AppColors.outlineVariant.withValues(alpha: 0.5),
            ),
          ),
          child: Column(
            children: [
              VerifyKeycodeInputs(controller: _otpController),
              const SizedBox(height: AppSpacing.spaceMd),
              Container(height: 1, color: AppColors.surfaceContainer),
              const SizedBox(height: AppSpacing.spaceMd),
              VerifyNewPasswordSection(
                passwordController: _passwordController,
                confirmPasswordController: _confirmPasswordController,
              ),
              const SizedBox(height: AppSpacing.spaceLg),
              VerifyResetSubmitButton(
                onPressed: isLoading ? null : _onSubmit,
              ),
            ],
          ),
        );
      },
    );
  }
}
