import 'dart:async';
import 'package:aura/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Pure form controller for VerifyOtpForm isolating 6-digit controllers, focus nodes, countdown timer, and event dispatching.
class VerifyOtpFormController {
  final List<TextEditingController> controllers =
      List.generate(6, (_) => TextEditingController());
  final List<FocusNode> focusNodes = List.generate(6, (_) => FocusNode());

  Timer? _timer;
  int secondsRemaining = 120;
  bool canResend = false;
  final VoidCallback? onTick;

  VerifyOtpFormController({this.onTick}) {
    startTimer();
  }

  void dispose() {
    _timer?.cancel();
    for (final c in controllers) {
      c.dispose();
    }
    for (final f in focusNodes) {
      f.dispose();
    }
  }

  void startTimer() {
    _timer?.cancel();
    secondsRemaining = 120;
    canResend = false;
    onTick?.call();
    _timer = Timer.periodic(const Duration(seconds: 1), (t) {
      if (secondsRemaining == 0) {
        t.cancel();
        canResend = true;
        onTick?.call();
      } else {
        secondsRemaining--;
        onTick?.call();
      }
    });
  }

  String get formattedTimer {
    final m = (secondsRemaining ~/ 60).toString().padLeft(2, '0');
    final s = (secondsRemaining % 60).toString().padLeft(2, '0');
    return '$m:$s';
  }

  String get otp => controllers.map((c) => c.text).join();

  void onVerify(BuildContext context) {
    context.read<AuthCubit>().verifyResetOtp(otp: otp);
  }

  void onResend(BuildContext context, {required String email}) {
    if (!canResend) return;
    context.read<AuthCubit>().resendOtp(email: email);
  }

  void onOtpChanged(BuildContext context, String value, int index) {
    if (value.length == 1 && index < 5) {
      focusNodes[index + 1].requestFocus();
    } else if (value.isEmpty && index > 0) {
      focusNodes[index - 1].requestFocus();
    }
    if (otp.length == 6) {
      onVerify(context);
    }
  }

  void reset() {
    for (final c in controllers) {
      c.clear();
    }
    if (focusNodes.isNotEmpty) {
      focusNodes.first.requestFocus();
    }
  }
}
