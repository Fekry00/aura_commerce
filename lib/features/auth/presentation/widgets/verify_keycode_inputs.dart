import 'package:aura/core/theme/app_typography.dart';
import 'package:aura/features/auth/presentation/controllers/verify_keycode_controller.dart';
import 'package:aura/features/auth/presentation/widgets/verify_keycode_header_row.dart';
import 'package:aura/features/auth/presentation/widgets/verify_otp_cell.dart';
import 'package:aura/features/auth/presentation/widgets/verify_resend_code_row.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// Pure declarative UI widget for Keycode input cells.
class VerifyKeycodeInputs extends StatefulWidget {
  final TextEditingController controller;
  final VerifyKeycodeController? keycodeController;

  const VerifyKeycodeInputs({
    super.key,
    required this.controller,
    this.keycodeController,
  });

  @override
  State<VerifyKeycodeInputs> createState() => _VerifyKeycodeInputsState();
}

class _VerifyKeycodeInputsState extends State<VerifyKeycodeInputs> {
  late final VerifyKeycodeController _keycodeController;
  late final bool _internalController;

  @override
  void initState() {
    super.initState();
    _internalController = widget.keycodeController == null;
    _keycodeController = widget.keycodeController ??
        VerifyKeycodeController(onTick: () {
          if (mounted) setState(() {});
        });
    widget.controller.addListener(_onChanged);
  }

  void _onChanged() => setState(() {});

  @override
  void dispose() {
    widget.controller.removeListener(_onChanged);
    if (_internalController) {
      _keycodeController.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final text = widget.controller.text;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        VerifyKeycodeHeaderRow(
          formattedTimer: _keycodeController.timerFormatted,
        ),
        const SizedBox(height: AppSpacing.spaceSm + 2),
        GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () => _keycodeController.focusNode.requestFocus(),
          child: Stack(
            children: [
              Opacity(
                opacity: 0.0,
                child: SizedBox(
                  height: 56,
                  child: TextField(
                    controller: widget.controller,
                    focusNode: _keycodeController.focusNode,
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
                    isActive: _keycodeController.focusNode.hasFocus &&
                        i == text.length.clamp(0, 5),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: AppSpacing.spaceSm + 2),
        VerifyResendCodeRow(
          secondsRemaining: _keycodeController.secondsRemaining,
          formattedTimer: _keycodeController.timerFormatted,
          onResendCode: () => _keycodeController.onResendCode(context),
          onRequestSms: () => _keycodeController.onRequestSms(context),
        ),
      ],
    );
  }
}
