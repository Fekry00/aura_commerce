import 'package:aura/core/routing/routes.dart';
import 'package:aura/core/theme/app_typography.dart';
import 'package:aura/core/utils/functions/custom_snack_bar.dart';
import 'package:aura/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:aura/features/auth/presentation/cubit/auth_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'auth_field_header.dart';
import 'auth_text_form_field.dart';

class ForgotPasswordForm extends StatefulWidget {
  const ForgotPasswordForm({super.key});

  @override
  State<ForgotPasswordForm> createState() => _ForgotPasswordFormState();
}

class _ForgotPasswordFormState extends State<ForgotPasswordForm> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  void _onSubmit() {
    if (_formKey.currentState!.validate()) {
      context.read<AuthCubit>().forgotPassword(
            email: _emailController.text.trim(),
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthErrorState) {
          showCustomSnackBar(
            context,
            message: state.message,
            type: SnackBarType.error,
          );
        } else if (state is AuthOtpSentState) {
          showCustomSnackBar(
            context,
            message: 'A reset code has been sent to your email.',
            type: SnackBarType.success,
          );
          Navigator.pushReplacementNamed(
            context,
            Routes.verifyOtpView,
            arguments: {'email': _emailController.text.trim()},
          );
        }
      },
      builder: (context, state) {
        final isLoading = state is AuthLoadingState;

        return Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const AuthFieldHeader(
                label: 'EMAIL ADDRESS',
                isRequired: true,
                trailingText: 'Concierge Verified',
                trailingColor: Color(0xFF0B3B2C),
              ),
              const SizedBox(height: AppSpacing.spaceXs),
              AuthTextFormField(
                controller: _emailController,
                hintText: 'name@gmail.com',
                prefixIcon: Icons.mail_outline_rounded,
                keyboardType: TextInputType.emailAddress,
                validator: (val) {
                  if (val == null || val.trim().isEmpty) {
                    return 'Email address is required';
                  }
                  if (!RegExp(r'^[\w-.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(val.trim())) {
                    return 'Enter a valid email address';
                  }
                  return null;
                },
              ),
              const SizedBox(height: AppSpacing.spaceXl),

              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  onPressed: isLoading ? null : _onSubmit,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF0B3B2C),
                    foregroundColor: Colors.white,
                    disabledBackgroundColor: const Color(0xFF0B3B2C).withValues(alpha: 0.6),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 0,
                  ),
                  child: isLoading
                      ? const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Colors.white,
                          ),
                        )
                      : Text(
                          'Send Reset Code',
                          style: AppTypography.labelCaps.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                            fontSize: 13,
                            letterSpacing: 1.0,
                          ),
                        ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
