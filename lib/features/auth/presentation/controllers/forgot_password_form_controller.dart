import 'package:aura/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:aura/features/auth/presentation/utils/auth_validation_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Pure form controller for ForgotPasswordForm isolating controllers, keys, and event dispatching.
class ForgotPasswordFormController {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();

  void dispose() {
    emailController.dispose();
  }

  void onSubmit(BuildContext context) {
    final isValid = formKey.currentState?.validate() ?? false;
    context.read<AuthCubit>().forgotPassword(
          email: emailController.text.trim(),
          isFormValid: isValid,
        );
  }

  String? validateEmail(String? val) {
    if (val == null || val.trim().isEmpty) {
      return 'Email address is required';
    }
    if (!AuthValidationHelper.isValidEmail(val)) {
      return 'Enter a valid email address';
    }
    return null;
  }
}
