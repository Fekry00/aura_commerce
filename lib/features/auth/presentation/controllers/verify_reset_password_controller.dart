import 'package:aura/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Pure form controller for VerifyResetPasswordCard isolating controllers and event dispatching.
class VerifyResetPasswordController {
  final otpController = TextEditingController(text: '8429');
  final passwordController = TextEditingController(text: 'Atelier2025#');
  final confirmPasswordController = TextEditingController(text: 'Atelier2025#');

  void dispose() {
    otpController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
  }

  void onSubmit(BuildContext context) {
    context.read<AuthCubit>().resetPassword(
          otp: otpController.text.trim(),
          newPassword: passwordController.text,
          confirmPassword: confirmPasswordController.text,
        );
  }
}
