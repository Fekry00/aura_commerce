import 'dart:async';
import 'package:aura/core/theme/app_typography.dart';
import 'package:aura/core/utils/functions/custom_snack_bar.dart';
import 'package:aura/features/auth/presentation/widgets/verify_keycode_header_row.dart';
import 'package:aura/features/auth/presentation/widgets/verify_otp_cell.dart';
import 'package:aura/features/auth/presentation/widgets/verify_resend_code_row.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class VerifyKeycodeInputs extends StatefulWidget {
  final TextEditingController controller;
  const VerifyKeycodeInputs({super.key, required this.controller});

  @override
  State<VerifyKeycodeInputs> createState() => _VerifyKeycodeInputsState();
}

class _VerifyKeycodeInputsState extends State<VerifyKeycodeInputs> {
  final FocusNode _focusNode = FocusNode();
  Timer? _timer;
  int _secondsRemaining = 40;

  @override
  void initState() {
    super.initState();
    _startCountdown();
    widget.controller.addListener(_onChanged);
  }

  void _onChanged() => setState(() {});

  void _startCountdown() {
    _timer?.cancel();
    setState(() => _secondsRemaining = 40);
    _timer = Timer.periodic(const Duration(seconds: 1), (t) {
      if (_secondsRemaining > 0) {
        setState(() => _secondsRemaining--);
      } else {
        t.cancel();
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    widget.controller.removeListener(_onChanged);
    _focusNode.dispose();
    super.dispose();
  }

  String get _timerFormatted => '00:${_secondsRemaining < 10 ? '0$_secondsRemaining' : '$_secondsRemaining'}';

  @override
  Widget build(BuildContext context) {
    final text = widget.controller.text;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        VerifyKeycodeHeaderRow(formattedTimer: _timerFormatted),
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
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly, LengthLimitingTextInputFormatter(6)],
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(6, (i) => VerifyOtpCell(digit: i < text.length ? text[i] : null, isActive: _focusNode.hasFocus && i == text.length.clamp(0, 5))),
              ),
            ],
          ),
        ),
        const SizedBox(height: AppSpacing.spaceSm + 2),
        VerifyResendCodeRow(
          secondsRemaining: _secondsRemaining,
          formattedTimer: _timerFormatted,
          onResendCode: () {
            _startCountdown();
            showCustomSnackBar(context, message: 'New keycode dispatched.', type: SnackBarType.success);
          },
          onRequestSms: () => showCustomSnackBar(context, message: 'Authorization keycode dispatched via SMS.', type: SnackBarType.info),
        ),
      ],
    );
  }
}
