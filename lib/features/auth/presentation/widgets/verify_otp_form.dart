import 'dart:async';
import 'package:aura/core/routing/routes.dart';
import 'package:aura/core/theme/app_colors.dart';
import 'package:aura/core/theme/app_typography.dart';
import 'package:aura/core/utils/functions/custom_snack_bar.dart';
import 'package:aura/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:aura/features/auth/presentation/cubit/auth_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'verify_otp_input_cell.dart';

class VerifyOtpForm extends StatefulWidget {
  final String email;

  const VerifyOtpForm({super.key, required this.email});

  @override
  State<VerifyOtpForm> createState() => _VerifyOtpFormState();
}

class _VerifyOtpFormState extends State<VerifyOtpForm> {
  final List<TextEditingController> _controllers =
      List.generate(6, (_) => TextEditingController());
  final List<FocusNode> _focusNodes = List.generate(6, (_) => FocusNode());

  Timer? _timer;
  int _secondsRemaining = 120;
  bool _canResend = false;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  @override
  void dispose() {
    _timer?.cancel();
    for (final c in _controllers) {
      c.dispose();
    }
    for (final f in _focusNodes) {
      f.dispose();
    }
    super.dispose();
  }

  void _startTimer() {
    _timer?.cancel();
    setState(() {
      _secondsRemaining = 120;
      _canResend = false;
    });
    _timer = Timer.periodic(const Duration(seconds: 1), (t) {
      if (_secondsRemaining == 0) {
        t.cancel();
        setState(() => _canResend = true);
      } else {
        setState(() => _secondsRemaining--);
      }
    });
  }

  String get _formattedTimer {
    final m = (_secondsRemaining ~/ 60).toString().padLeft(2, '0');
    final s = (_secondsRemaining % 60).toString().padLeft(2, '0');
    return '$m:$s';
  }

  String get _otp => _controllers.map((c) => c.text).join();

  void _onVerify() {
    if (_otp.length < 6) {
      showCustomSnackBar(
        context,
        message: 'Please enter all 6 digits.',
        type: SnackBarType.error,
      );
      return;
    }
    context.read<AuthCubit>().verifyResetOtp(otp: _otp);
  }

  void _onResend() {
    if (!_canResend) return;
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

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthErrorState) {
          showCustomSnackBar(context, message: state.message, type: SnackBarType.error);
          for (final c in _controllers) {
            c.clear();
          }
          _focusNodes.first.requestFocus();
        } else if (state is AuthOtpSentState) {
          showCustomSnackBar(context, message: 'Code resent successfully.', type: SnackBarType.success);
          _startTimer();
          for (final c in _controllers) {
            c.clear();
          }
          _focusNodes.first.requestFocus();
        } else if (state is AuthOtpVerifiedState) {
          Navigator.pushReplacementNamed(
            context,
            Routes.resetPasswordView,
            arguments: {'otp': _otp},
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
                  controller: _controllers[index],
                  focusNode: _focusNodes[index],
                  onChanged: (val) => _onOtpChanged(val, index),
                );
              }),
            ),
            const SizedBox(height: AppSpacing.spaceLg),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: _onResend,
                  child: Text(
                    _canResend ? 'Resend code now' : 'Resend in $_formattedTimer',
                    style: AppTypography.labelSm.copyWith(
                      color: _canResend ? const Color(0xFF0B3B2C) : const Color(0xFF9CA3AF),
                      fontWeight: _canResend ? FontWeight.w700 : FontWeight.w500,
                    ),
                  ),
                ),
                Text(
                  'Expires in $_formattedTimer',
                  style: AppTypography.labelSm.copyWith(
                    color: _secondsRemaining < 30 ? AppColors.error : AppColors.slateBody,
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.spaceXl),

            SizedBox(
              width: double.infinity,
              height: 52,
              child: ElevatedButton(
                onPressed: isLoading ? null : _onVerify,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF0B3B2C),
                  foregroundColor: Colors.white,
                  disabledBackgroundColor: const Color(0xFF0B3B2C).withValues(alpha: 0.6),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 0,
                ),
                child: isLoading
                    ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Colors.white,
                        ),
                      )
                    : Text(
                        'Verify & Proceed',
                        style: AppTypography.labelCaps.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                          fontSize: 13,
                          letterSpacing: 1.0,
                        ),
                      ),
              ),
            ),
          ],
        );
      },
    );
  }
}
