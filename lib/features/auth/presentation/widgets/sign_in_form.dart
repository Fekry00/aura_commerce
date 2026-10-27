import 'package:aura/core/routing/routes.dart';
import 'package:aura/core/theme/app_typography.dart';
import 'package:aura/core/utils/functions/custom_snack_bar.dart';
import 'package:aura/features/auth/presentation/controllers/sign_in_form_controller.dart';
import 'package:aura/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:aura/features/auth/presentation/cubit/auth_state.dart';
import 'package:aura/features/cart/presentation/cubit/cart_cubit.dart';
import 'package:aura/features/wishlist/presentation/cubit/wishlist_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'auth_field_header.dart';
import 'auth_text_form_field.dart';
import 'fast_sign_in_button.dart';
import 'sign_in_actions_row.dart';
import 'sign_in_submit_button.dart';

/// Pure declarative UI widget for Sign In form.
class SignInForm extends StatefulWidget {
  final String? initialEmail;
  final SignInFormController? controller;

  const SignInForm({super.key, this.initialEmail, this.controller});

  @override
  State<SignInForm> createState() => _SignInFormState();
}

class _SignInFormState extends State<SignInForm> {
  late final SignInFormController _controller;
  late final bool _internalController;

  @override
  void initState() {
    super.initState();
    _internalController = widget.controller == null;
    _controller = widget.controller ??
        SignInFormController(initialEmail: widget.initialEmail);
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
    return Form(
      key: _controller.formKey,
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
            controller: _controller.emailController,
            hintText: 'name@gmail.com',
            prefixIcon: Icons.mail_outline_rounded,
            keyboardType: TextInputType.emailAddress,
            validator: _controller.validateEmail,
          ),
          const SizedBox(height: AppSpacing.spaceMd),

          const AuthFieldHeader(
            label: 'PASSKEY OR PASSWORD',
            trailingText: 'Private Code',
          ),
          const SizedBox(height: AppSpacing.spaceXs),
          AuthTextFormField(
            controller: _controller.passwordController,
            obscureText: _controller.obscurePassword,
            hintText: 'Enter your confidential passkey',
            prefixIcon: Icons.lock_outline_rounded,
            validator: _controller.validatePassword,
            suffixWidget: IconButton(
              icon: Icon(
                _controller.obscurePassword
                    ? Icons.visibility_off_outlined
                    : Icons.visibility_outlined,
                size: 18,
                color: const Color(0xFF9CA3AF),
              ),
              onPressed: () =>
                  setState(() => _controller.toggleObscurePassword()),
            ),
          ),
          const SizedBox(height: AppSpacing.spaceSm + 2),

          SignInActionsRow(
            rememberDevice: _controller.rememberDevice,
            onRememberChanged: (val) =>
                setState(() => _controller.setRememberDevice(val)),
          ),
          const SizedBox(height: AppSpacing.spaceLg),

          BlocConsumer<AuthCubit, AuthState>(
            listener: (context, state) {
              if (state is AuthErrorState) {
                showCustomSnackBar(
                  context,
                  message: state.message,
                  type: SnackBarType.error,
                );
              } else if (state is AuthInfoMessageState) {
                showCustomSnackBar(
                  context,
                  message: state.message,
                  type: SnackBarType.info,
                );
              } else if (state is AuthSuccessState) {
                context.read<CartCubit>().fetchCart();
                context.read<WishlistCubit>().fetchWishlist();
                showCustomSnackBar(
                  context,
                  message: 'Welcome back, ${state.auth.name}!',
                  type: SnackBarType.success,
                );
                Navigator.pushReplacementNamed(context, Routes.homeView);
              }
            },
            builder: (context, state) {
              final isLoading = state is AuthLoadingState;
              return SignInSubmitButton(
                isLoading: isLoading,
                onPressed: () => _controller.onSignIn(context),
              );
            },
          ),
          const SizedBox(height: AppSpacing.spaceSm + 4),

          const FastSignInButton(),
        ],
      ),
    );
  }
}