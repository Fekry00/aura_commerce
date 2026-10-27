import 'package:aura/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:aura/features/auth/presentation/utils/auth_validation_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Pure form controller for CreateAccountForm isolating controllers, keys, and event dispatching.
class CreateAccountFormController {
  final formKey = GlobalKey<FormState>();

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  void dispose() {
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
  }

  void onRegisterPressed(BuildContext context) {
    final isValid = formKey.currentState?.validate() ?? false;
    context.read<AuthCubit>().signUp(
          name: nameController.text.trim(),
          email: emailController.text.trim(),
          phone: phoneController.text.trim(),
          password: passwordController.text,
          confirmPassword: confirmPasswordController.text,
          isFormValid: isValid,
        );
  }

  String? validateName(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Full legal name is required';
    }
    return null;
  }

  String? validateEmail(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Email address is required';
    }
    if (!AuthValidationHelper.isValidEmail(value)) {
      return 'Please enter a valid email address';
    }
    return null;
  }
}
