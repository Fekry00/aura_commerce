import 'package:aura/core/routing/routes.dart';
import 'package:aura/core/theme/app_typography.dart';
import 'package:aura/core/utils/functions/custom_snack_bar.dart';
import 'package:aura/features/auth/presentation/controllers/forgot_password_form_controller.dart';
import 'package:aura/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:aura/features/auth/presentation/cubit/auth_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'auth_field_header.dart';
import 'auth_text_form_field.dart';
import 'forgot_password_submit_button.dart';

/// Pure declarative UI widget for Forgot Password form.
class ForgotPasswordForm extends StatefulWidget {
  final ForgotPasswordFormController? controller;

  const ForgotPasswordForm({super.key, this.controller});

  @override
  State<ForgotPasswordForm> createState() => _ForgotPasswordFormState();
}

class _ForgotPasswordFormState extends State<ForgotPasswordForm> {
  late final ForgotPasswordFormController _controller;
  late final bool _internalController;

  @override
  void initState() {
    super.initState();
    _internalController = widget.controller == null;
    _controller = widget.controller ?? ForgotPasswordFormController();
  }

  @override
  void dispose() {
    if (_internalController) {
      _controller.dispose();
    }
    super.dispose();
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
            arguments: {'email': _controller.emailController.text.trim()},
          );
        }
      },
      builder: (context, state) {
        final isLoading = state is AuthLoadingState;

        return Form(
          key: _controller.formKey,
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
                controller: _controller.emailController,
                hintText: 'name@gmail.com',
                prefixIcon: Icons.mail_outline_rounded,
                keyboardType: TextInputType.emailAddress,
                validator: _controller.validateEmail,
              ),
              const SizedBox(height: AppSpacing.spaceXl),

              ForgotPasswordSubmitButton(
                isLoading: isLoading,
                onPressed: () => _controller.onSubmit(context),
              ),
            ],
          ),
        );
      },
    );
  }
}
