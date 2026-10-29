import 'package:aura/core/routing/routes.dart';
import 'package:aura/core/theme/app_typography.dart';
import 'package:aura/core/utils/functions/custom_snack_bar.dart';
import 'package:aura/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:aura/features/auth/presentation/cubit/auth_state.dart';
import 'package:aura/features/auth/presentation/utils/auth_validation_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'auth_field_header.dart';
import 'auth_passphrase_section.dart';
import 'auth_phone_field.dart';
import 'auth_salon_and_terms.dart';
import 'auth_text_form_field.dart';
import 'create_account_submit_button.dart';

/// Pure declarative UI widget for account creation form.
class CreateAccountForm extends StatefulWidget {
  const CreateAccountForm({super.key});

  @override
  State<CreateAccountForm> createState() => _CreateAccountFormState();
}

class _CreateAccountFormState extends State<CreateAccountForm> {
  final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _onRegisterPressed() {
    final isValid = _formKey.currentState?.validate() ?? false;
    context.read<AuthCubit>().signUp(
          name: _nameController.text.trim(),
          email: _emailController.text.trim(),
          phone: _phoneController.text.trim(),
          password: _passwordController.text,
          confirmPassword: _confirmPasswordController.text,
          isFormValid: isValid,
        );
  }

  String? _validateName(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Full legal name is required';
    }
    return null;
  }

  String? _validateEmail(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Email address is required';
    }
    if (!AuthValidationHelper.isValidEmail(value)) {
      return 'Please enter a valid email address';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const AuthFieldHeader(
            label: 'FULL LEGAL NAME',
            isRequired: true,
            trailingText: 'REQUIRED',
          ),
          const SizedBox(height: AppSpacing.spaceXs),
          AuthTextFormField(
            controller: _nameController,
            hintText: 'Name',
            prefixIcon: Icons.person_outline_rounded,
            validator: _validateName,
          ),
          const SizedBox(height: AppSpacing.spaceMd),

          const AuthFieldHeader(
            label: 'EMAIL ADDRESS',
            isRequired: true,
            trailingText: 'ATELIER DISPATCH',
          ),
          const SizedBox(height: AppSpacing.spaceXs),
          AuthTextFormField(
            controller: _emailController,
            hintText: 'Name@gmail.com',
            prefixIcon: Icons.mail_outline_rounded,
            keyboardType: TextInputType.emailAddress,
            validator: _validateEmail,
          ),
          const SizedBox(height: AppSpacing.spaceMd),
          AuthPhoneField(controller: _phoneController),
          const SizedBox(height: AppSpacing.spaceMd),

          AuthPassphraseSection(
            passwordController: _passwordController,
            confirmPasswordController: _confirmPasswordController,
          ),
          const SizedBox(height: AppSpacing.spaceLg),
          const AuthSalonAndTerms(),
          const SizedBox(height: AppSpacing.spaceLg),
          BlocConsumer<AuthCubit, AuthState>(
            listener: (context, state) {
              if (state is AuthErrorState) {
                showCustomSnackBar(
                  context,
                  message: state.message,
                  type: SnackBarType.error,
                );
              } else if (state is AuthSuccessState) {
                showCustomSnackBar(
                  context,
                  message:
                      'Account created successfully! Please sign in to continue.',
                  type: SnackBarType.success,
                );
                Navigator.pushReplacementNamed(
                  context,
                  Routes.signInView,
                  arguments: _emailController.text.trim(),
                );
              }
            },
            builder: (context, state) {
              return CreateAccountSubmitButton(
                isLoading: state is AuthLoadingState,
                onPressed: _onRegisterPressed,
              );
            },
          ),
        ],
      ),
    );
  }
}