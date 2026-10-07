import 'package:aura/core/theme/app_typography.dart';
import 'package:aura/core/utils/functions/custom_snack_bar.dart';
import 'package:flutter/material.dart';
import 'auth_field_header.dart';
import 'auth_text_form_field.dart';
import 'fast_sign_in_button.dart';
import 'sign_in_actions_row.dart';
import 'sign_in_submit_button.dart';

class SignInForm extends StatefulWidget {
  const SignInForm({super.key});

  @override
  State<SignInForm> createState() => _SignInFormState();
}

class _SignInFormState extends State<SignInForm> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _obscurePassword = true;
  bool _rememberDevice = true;
  bool _isLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _onSignIn() async {
    if (_formKey.currentState!.validate()) {
      setState(() => _isLoading = true);
      await Future.delayed(const Duration(milliseconds: 1400));
      if (!mounted) return;
      setState(() => _isLoading = false);
      showCustomSnackBar(
        context,
        message: 'Welcome back to Aura Luxe Concierge.',
        type: SnackBarType.success,
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
          const AuthFieldHeader(
            label: 'EMAIL ADDRESS',
            trailingText: 'Concierge Verified',
            trailingColor: Color(0xFF0B3B2C),
          ),
          const SizedBox(height: AppSpacing.spaceXs),
          AuthTextFormField(
            controller: _emailController,
            hintText: 'name@gmail.com',
            prefixIcon: Icons.mail_outline_rounded,
            keyboardType: TextInputType.emailAddress,
            validator: (val) =>
                (val == null || val.trim().isEmpty) ? 'Email address is required' : null,
          ),
          const SizedBox(height: AppSpacing.spaceMd),

          const AuthFieldHeader(
            label: 'PASSKEY OR PASSWORD',
            trailingText: 'Private Code',
          ),
          const SizedBox(height: AppSpacing.spaceXs),
          AuthTextFormField(
            controller: _passwordController,
            obscureText: _obscurePassword,
            hintText: 'Enter your confidential passkey',
            prefixIcon: Icons.lock_outline_rounded,
            validator: (val) {
              if (val == null || val.trim().isEmpty) return 'Password is required';
              if (val.length < 8) return 'Password must be at least 8 characters';
              return null;
            },
            suffixWidget: IconButton(
              icon: Icon(
                _obscurePassword ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                size: 18,
                color: const Color(0xFF9CA3AF),
              ),
              onPressed: () => setState(() => _obscurePassword = !_obscurePassword),
            ),
          ),
          const SizedBox(height: AppSpacing.spaceSm + 2),

          SignInActionsRow(
            rememberDevice: _rememberDevice,
            onRememberChanged: (val) => setState(() => _rememberDevice = val),
          ),
          const SizedBox(height: AppSpacing.spaceLg),

          SignInSubmitButton(
            isLoading: _isLoading,
            onPressed: _onSignIn,
          ),
          const SizedBox(height: AppSpacing.spaceSm + 4),

          const FastSignInButton(),
        ],
      ),
    );
  }
}