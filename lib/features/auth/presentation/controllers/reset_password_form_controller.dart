import 'package:aura/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:aura/features/auth/presentation/utils/auth_validation_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Pure form controller for ResetPasswordForm isolating controllers, toggles, and event dispatching.
class ResetPasswordFormController {
  final formKey = GlobalKey<FormState>();

  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  bool obscurePassword = true;
  bool obscureConfirm = true;

  void dispose() {
    passwordController.dispose();
    confirmPasswordController.dispose();
  }

  void toggleObscurePassword() {
    obscurePassword = !obscurePassword;
  }

  void toggleObscureConfirm() {
    obscureConfirm = !obscureConfirm;
  }

  int get strength =>
      AuthValidationHelper.calculatePasswordStrength(passwordController.text);

  void onSubmit(BuildContext context, {required String otp}) {
    final isValid = formKey.currentState?.validate() ?? false;
    context.read<AuthCubit>().resetPassword(
          otp: otp,
          newPassword: passwordController.text,
          confirmPassword: confirmPasswordController.text,
          isFormValid: isValid,
        );
  }

  String? validatePassword(String? val) {
    if (val == null || val.isEmpty) return 'Password is required';
    if (val.length < 8) return 'Password must be at least 8 characters';
    return null;
  }

  String? validateConfirmPassword(String? val) {
    if (val == null || val.isEmpty) return 'Please confirm your password';
    if (val != passwordController.text) return 'Passwords do not match';
    return null;
  }
}
