import 'package:aura/core/routing/routes.dart';
import 'package:aura/core/theme/app_typography.dart';
import 'package:aura/core/utils/functions/custom_snack_bar.dart';
import 'package:aura/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:aura/features/auth/presentation/cubit/auth_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'auth_field_header.dart';
import 'auth_passphrase_section.dart';
import 'auth_phone_field.dart';
import 'auth_salon_and_terms.dart';
import 'auth_text_form_field.dart';

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
    if (_formKey.currentState!.validate()) {
      if (_passwordController.text != _confirmPasswordController.text) {
        showCustomSnackBar(
          context,
          message: 'Passwords do not match.',
          type: SnackBarType.error,
        );
        return;
      }

      context.read<AuthCubit>().signUp(
            name: _nameController.text.trim(),
            email: _emailController.text.trim(),
            phone: _phoneController.text.trim(),
            password: _passwordController.text,
          );
    } else {
      showCustomSnackBar(
        context,
        message: 'Please fill in all required fields properly.',
        type: SnackBarType.error,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const AuthFieldHeader(label: 'FULL LEGAL NAME', isRequired: true, trailingText: 'REQUIRED'),
          const SizedBox(height: AppSpacing.spaceXs),
          AuthTextFormField(
            controller: _nameController,
            hintText: 'Name',
            prefixIcon: Icons.person_outline_rounded,
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return 'Full legal name is required';
              }
              return null;
            },
          ),
          const SizedBox(height: AppSpacing.spaceMd),

          const AuthFieldHeader(label: 'EMAIL ADDRESS', isRequired: true, trailingText: 'ATELIER DISPATCH'),
          const SizedBox(height: AppSpacing.spaceXs),
          AuthTextFormField(
            controller: _emailController,
            hintText: 'Name@gmail.com',
            prefixIcon: Icons.mail_outline_rounded,
            keyboardType: TextInputType.emailAddress,
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return 'Email address is required';
              }
              final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
              if (!emailRegex.hasMatch(value.trim())) {
                return 'Please enter a valid email address';
              }
              return null;
            },
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
                  message: 'Welcome to Aura, ${state.auth.name}!',
                  type: SnackBarType.success,
                );
                Navigator.pushReplacementNamed(context, Routes.homeView);
              }
            },
            builder: (context, state) {
              final isLoading = state is AuthLoadingState;
              return SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF0B3B2C),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    elevation: 0,
                  ),
                  onPressed: isLoading ? null : _onRegisterPressed,
                  child: isLoading
                      ? const SizedBox(
                          width: 22,
                          height: 22,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                          ),
                        )
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Create Atelier Account',
                              style: AppTypography.bodySm.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.w700,
                                fontSize: 13,
                              ),
                            ),
                            const SizedBox(width: 8),
                            const Icon(Icons.arrow_forward, color: Colors.white, size: 16),
                          ],
                        ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}