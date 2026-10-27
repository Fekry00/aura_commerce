import 'package:aura/core/theme/app_colors.dart';
import 'package:aura/core/theme/app_typography.dart';
import 'package:aura/features/auth/presentation/controllers/verify_reset_password_controller.dart';
import 'package:aura/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:aura/features/auth/presentation/cubit/auth_state.dart';
import 'package:aura/features/auth/presentation/widgets/verify_keycode_inputs.dart';
import 'package:aura/features/auth/presentation/widgets/verify_new_password_section.dart';
import 'package:aura/features/auth/presentation/widgets/verify_reset_submit_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Pure declarative UI widget for reset password interactive card.
class VerifyResetPasswordCard extends StatefulWidget {
  final VerifyResetPasswordController? controller;

  const VerifyResetPasswordCard({super.key, this.controller});

  @override
  State<VerifyResetPasswordCard> createState() =>
      _VerifyResetPasswordCardState();
}

class _VerifyResetPasswordCardState extends State<VerifyResetPasswordCard> {
  late final VerifyResetPasswordController _controller;
  late final bool _internalController;

  @override
  void initState() {
    super.initState();
    _internalController = widget.controller == null;
    _controller = widget.controller ?? VerifyResetPasswordController();
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
              VerifyKeycodeInputs(controller: _controller.otpController),
              const SizedBox(height: AppSpacing.spaceMd),
              Container(height: 1, color: AppColors.surfaceContainer),
              const SizedBox(height: AppSpacing.spaceMd),
              VerifyNewPasswordSection(
                passwordController: _controller.passwordController,
                confirmPasswordController: _controller.confirmPasswordController,
              ),
              const SizedBox(height: AppSpacing.spaceLg),
              VerifyResetSubmitButton(
                onPressed: isLoading ? null : () => _controller.onSubmit(context),
              ),
            ],
          ),
        );
      },
    );
  }
}
