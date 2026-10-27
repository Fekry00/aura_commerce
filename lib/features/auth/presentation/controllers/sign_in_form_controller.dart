import 'package:aura/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Pure form controller for SignInForm isolating controllers, state toggles, and event dispatching.
class SignInFormController {
  final formKey = GlobalKey<FormState>();

  late final TextEditingController emailController;
  final passwordController = TextEditingController();

  bool rememberDevice = true;
  bool obscurePassword = true;

  SignInFormController({String? initialEmail}) {
    emailController = TextEditingController(text: initialEmail ?? '');
  }

  void dispose() {
    emailController.dispose();
    passwordController.dispose();
  }

  void toggleObscurePassword() {
    obscurePassword = !obscurePassword;
  }

  void setRememberDevice(bool value) {
    rememberDevice = value;
  }

  void onSignIn(BuildContext context) {
    final isValid = formKey.currentState?.validate() ?? false;
    context.read<AuthCubit>().signIn(
          email: emailController.text.trim(),
          password: passwordController.text,
          rememberDevice: rememberDevice,
          isFormValid: isValid,
        );
  }

  String? validateEmail(String? val) {
    if (val == null || val.trim().isEmpty) {
      return 'Email address is required';
    }
    return null;
  }

  String? validatePassword(String? val) {
    if (val == null || val.trim().isEmpty) {
      return 'Password is required';
    }
    if (val.length < 8) {
      return 'Password must be at least 8 characters';
    }
    return null;
  }
}
