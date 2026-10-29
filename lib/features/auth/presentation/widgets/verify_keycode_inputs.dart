import 'package:aura/core/theme/app_typography.dart';
import 'package:aura/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:aura/features/auth/presentation/cubit/auth_state.dart';
import 'package:aura/features/auth/presentation/widgets/verify_keycode_header_row.dart';
import 'package:aura/features/auth/presentation/widgets/verify_otp_cell.dart';
import 'package:aura/features/auth/presentation/widgets/verify_resend_code_row.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Pure declarative UI widget for Keycode input cells.
class VerifyKeycodeInputs extends StatefulWidget {
  final TextEditingController controller;

  const VerifyKeycodeInputs({
    super.key,
    required this.controller,
  });

  @override
  State<VerifyKeycodeInputs> createState() => _VerifyKeycodeInputsState();
}

class _VerifyKeycodeInputsState extends State<VerifyKeycodeInputs> {
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    widget.controller.addListener(_onChanged);
    _focusNode.addListener(_onChanged);
  }

  void _onChanged() {
    if (mounted) setState(() {});
  }

  @override
  void dispose() {
    widget.controller.removeListener(_onChanged);
    _focusNode.removeListener(_onChanged);
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        final cubit = context.read<AuthCubit>();
        final formattedTimer = state is AuthOtpTimerTickState
            ? state.formattedTimer
            : cubit.formattedOtpTimer;
        final secondsRemaining = state is AuthOtpTimerTickState
            ? state.secondsRemaining
            : cubit.otpSecondsRemaining;

        final text = widget.controller.text;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            VerifyKeycodeHeaderRow(
              formattedTimer: formattedTimer,
            ),
            const SizedBox(height: AppSpacing.spaceSm + 2),
            GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () => _focusNode.requestFocus(),
              child: Stack(
                children: [
                  Opacity(
                    opacity: 0.0,
                    child: SizedBox(
                      height: 56,
                      child: TextField(
                        controller: widget.controller,
                        focusNode: _focusNode,
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                          LengthLimitingTextInputFormatter(6),
                        ],
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: List.generate(
                      6,
                      (i) => VerifyOtpCell(
                        digit: i < text.length ? text[i] : null,
                        isActive: _focusNode.hasFocus &&
                            i == text.length.clamp(0, 5),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: AppSpacing.spaceSm + 2),
            VerifyResendCodeRow(
              secondsRemaining: secondsRemaining,
              formattedTimer: formattedTimer,
              onResendCode: () => cubit.dispatchKeycode(),
              onRequestSms: () => cubit.dispatchKeycodeSms(),
            ),
          ],
        );
      },
    );
  }
}
