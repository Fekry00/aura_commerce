import 'package:aura/core/routing/routes.dart';
import 'package:aura/core/theme/app_typography.dart';
import 'package:aura/core/utils/functions/custom_snack_bar.dart';
import 'package:aura/features/auth/presentation/controllers/create_account_form_controller.dart';
import 'package:aura/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:aura/features/auth/presentation/cubit/auth_state.dart';
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
  final CreateAccountFormController? controller;

  const CreateAccountForm({super.key, this.controller});

  @override
  State<CreateAccountForm> createState() => _CreateAccountFormState();
}

class _CreateAccountFormState extends State<CreateAccountForm> {
  late final CreateAccountFormController _controller;
  late final bool _internalController;

  @override
  void initState() {
    super.initState();
    _internalController = widget.controller == null;
    _controller = widget.controller ?? CreateAccountFormController();
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
            label: 'FULL LEGAL NAME',
            isRequired: true,
            trailingText: 'REQUIRED',
          ),
          const SizedBox(height: AppSpacing.spaceXs),
          AuthTextFormField(
            controller: _controller.nameController,
            hintText: 'Name',
            prefixIcon: Icons.person_outline_rounded,
            validator: _controller.validateName,
          ),
          const SizedBox(height: AppSpacing.spaceMd),

          const AuthFieldHeader(
            label: 'EMAIL ADDRESS',
            isRequired: true,
            trailingText: 'ATELIER DISPATCH',
          ),
          const SizedBox(height: AppSpacing.spaceXs),
          AuthTextFormField(
            controller: _controller.emailController,
            hintText: 'Name@gmail.com',
            prefixIcon: Icons.mail_outline_rounded,
            keyboardType: TextInputType.emailAddress,
            validator: _controller.validateEmail,
          ),
          const SizedBox(height: AppSpacing.spaceMd),
          AuthPhoneField(controller: _controller.phoneController),
          const SizedBox(height: AppSpacing.spaceMd),

          AuthPassphraseSection(
            passwordController: _controller.passwordController,
            confirmPasswordController: _controller.confirmPasswordController,
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
                  message: 'Account created successfully! Please sign in to continue.',
                  type: SnackBarType.success,
                );
                Navigator.pushReplacementNamed(
                  context,
                  Routes.signInView,
                  arguments: _controller.emailController.text.trim(),
                );
              }
            },
            builder: (context, state) {
              return CreateAccountSubmitButton(
                isLoading: state is AuthLoadingState,
                onPressed: () => _controller.onRegisterPressed(context),
              );
            },
          ),
        ],
      ),
    );
  }
}