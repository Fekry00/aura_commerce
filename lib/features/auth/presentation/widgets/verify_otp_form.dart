import 'package:aura/core/routing/routes.dart';
import 'package:aura/core/theme/app_typography.dart';
import 'package:aura/core/utils/functions/custom_snack_bar.dart';
import 'package:aura/features/auth/presentation/controllers/verify_otp_form_controller.dart';
import 'package:aura/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:aura/features/auth/presentation/cubit/auth_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'verify_otp_countdown_row.dart';
import 'verify_otp_input_cell.dart';
import 'verify_otp_submit_button.dart';

/// Pure declarative UI widget for OTP verification form.
class VerifyOtpForm extends StatefulWidget {
  final String email;
  final VerifyOtpFormController? controller;

  const VerifyOtpForm({
    super.key,
    required this.email,
    this.controller,
  });

  @override
  State<VerifyOtpForm> createState() => _VerifyOtpFormState();
}

class _VerifyOtpFormState extends State<VerifyOtpForm> {
  late final VerifyOtpFormController _controller;
  late final bool _internalController;

  @override
  void initState() {
    super.initState();
    _internalController = widget.controller == null;
    _controller = widget.controller ??
        VerifyOtpFormController(onTick: () {
          if (mounted) setState(() {});
        });
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
          _controller.reset();
        } else if (state is AuthOtpSentState) {
          showCustomSnackBar(
            context,
            message: 'Code resent successfully.',
            type: SnackBarType.success,
          );
          _controller.startTimer();
          _controller.reset();
        } else if (state is AuthOtpVerifiedState) {
          Navigator.pushReplacementNamed(
            context,
            Routes.resetPasswordView,
            arguments: {'otp': _controller.otp},
          );
        }
      },
      builder: (context, state) {
        final isLoading = state is AuthLoadingState;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(6, (index) {
                return VerifyOtpInputCell(
                  controller: _controller.controllers[index],
                  focusNode: _controller.focusNodes[index],
                  onChanged: (val) =>
                      _controller.onOtpChanged(context, val, index),
                );
              }),
            ),
            const SizedBox(height: AppSpacing.spaceLg),

            VerifyOtpCountdownRow(
              canResend: _controller.canResend,
              formattedTimer: _controller.formattedTimer,
              secondsRemaining: _controller.secondsRemaining,
              onResend: () => _controller.onResend(context, email: widget.email),
            ),
            const SizedBox(height: AppSpacing.spaceXl),

            VerifyOtpSubmitButton(
              isLoading: isLoading,
              onPressed: () => _controller.onVerify(context),
            ),
          ],
        );
      },
    );
  }
}
