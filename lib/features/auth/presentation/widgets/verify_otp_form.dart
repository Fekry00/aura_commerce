import 'package:aura/core/routing/routes.dart';
import 'package:aura/core/theme/app_typography.dart';
import 'package:aura/core/utils/functions/custom_snack_bar.dart';
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

  const VerifyOtpForm({
    super.key,
    required this.email,
  });

  @override
  State<VerifyOtpForm> createState() => _VerifyOtpFormState();
}

class _VerifyOtpFormState extends State<VerifyOtpForm> {
  final List<TextEditingController> _controllers =
      List.generate(6, (_) => TextEditingController());
  final List<FocusNode> _focusNodes = List.generate(6, (_) => FocusNode());

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        final cubit = context.read<AuthCubit>();
        if (cubit.otpSecondsRemaining == 0) {
          cubit.startOtpTimer();
        }
      }
    });
  }

  @override
  void dispose() {
    for (final c in _controllers) {
      c.dispose();
    }
    for (final f in _focusNodes) {
      f.dispose();
    }
    super.dispose();
  }

  String get _otp => _controllers.map((c) => c.text).join();

  void _onVerify() {
    context.read<AuthCubit>().verifyResetOtp(
          otp: _otp,
          email: widget.email,
        );
  }

  void _onResend() {
    context.read<AuthCubit>().resendOtp(email: widget.email);
  }

  void _onOtpChanged(String value, int index) {
    if (value.length == 1 && index < 5) {
      _focusNodes[index + 1].requestFocus();
    } else if (value.isEmpty && index > 0) {
      _focusNodes[index - 1].requestFocus();
    }
    if (_otp.length == 6) {
      _onVerify();
    }
  }

  void _resetInputs() {
    for (final c in _controllers) {
      c.clear();
    }
    if (_focusNodes.isNotEmpty) {
      _focusNodes.first.requestFocus();
    }
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
          _resetInputs();
        } else if (state is AuthOtpSentState) {
          showCustomSnackBar(
            context,
            message: 'Code resent successfully.',
            type: SnackBarType.success,
          );
          _resetInputs();
        } else if (state is AuthOtpVerifiedState) {
          Navigator.pushReplacementNamed(
            context,
            Routes.resetPasswordView,
            arguments: {'otp': _otp, 'email': widget.email},
          );
        }
      },
      builder: (context, state) {
        final isLoading = state is AuthLoadingState;
        final cubit = context.read<AuthCubit>();
        final canResend = state is AuthOtpTimerTickState
            ? state.canResend
            : cubit.canResendOtp;
        final formattedTimer = state is AuthOtpTimerTickState
            ? state.formattedTimer
            : cubit.formattedOtpTimer;
        final secondsRemaining = state is AuthOtpTimerTickState
            ? state.secondsRemaining
            : cubit.otpSecondsRemaining;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(6, (index) {
                return VerifyOtpInputCell(
                  controller: _controllers[index],
                  focusNode: _focusNodes[index],
                  onChanged: (val) => _onOtpChanged(val, index),
                );
              }),
            ),
            const SizedBox(height: AppSpacing.spaceLg),

            VerifyOtpCountdownRow(
              canResend: canResend,
              formattedTimer: formattedTimer,
              secondsRemaining: secondsRemaining,
              onResend: _onResend,
            ),
            const SizedBox(height: AppSpacing.spaceXl),

            VerifyOtpSubmitButton(
              isLoading: isLoading,
              onPressed: _onVerify,
            ),
          ],
        );
      },
    );
  }
}
