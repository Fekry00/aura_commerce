import 'dart:async';
import 'package:aura/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Pure form controller for VerifyKeycodeInputs isolating countdown timer, focus node, and dispatch triggers.
class VerifyKeycodeController {
  final FocusNode focusNode = FocusNode();
  Timer? _timer;
  int secondsRemaining = 40;
  final VoidCallback? onTick;

  VerifyKeycodeController({this.onTick}) {
    startCountdown();
  }

  void dispose() {
    _timer?.cancel();
    focusNode.dispose();
  }

  void startCountdown() {
    _timer?.cancel();
    secondsRemaining = 40;
    onTick?.call();
    _timer = Timer.periodic(const Duration(seconds: 1), (t) {
      if (secondsRemaining > 0) {
        secondsRemaining--;
        onTick?.call();
      } else {
        t.cancel();
      }
    });
  }

  String get timerFormatted =>
      '00:${secondsRemaining < 10 ? '0$secondsRemaining' : '$secondsRemaining'}';

  void onResendCode(BuildContext context) {
    startCountdown();
    context.read<AuthCubit>().dispatchKeycode();
  }

  void onRequestSms(BuildContext context) {
    context.read<AuthCubit>().dispatchKeycodeSms();
  }
}
