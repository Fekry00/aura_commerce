import 'package:aura/core/theme/app_colors.dart';
import 'package:aura/core/theme/app_typography.dart';
import 'package:aura/features/auth/presentation/widgets/auth_text_form_field.dart';
import 'package:flutter/material.dart';

import 'package:aura/features/profile/presentation/utils/profile_validators.dart';

class EditProfileCredentialsSection extends StatefulWidget {
  final String initialName;
  final String initialEmail;
  final bool isLoading;
  final void Function({required String name, required String email}) onSave;

  const EditProfileCredentialsSection({
    super.key,
    required this.initialName,
    required this.initialEmail,
    this.isLoading = false,
    required this.onSave,
  });

  @override
  State<EditProfileCredentialsSection> createState() =>
      _EditProfileCredentialsSectionState();
}

class _EditProfileCredentialsSectionState
    extends State<EditProfileCredentialsSection> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _nameController;
  late final TextEditingController _emailController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.initialName);
    _emailController = TextEditingController(text: widget.initialEmail);
  }

  @override
  void didUpdateWidget(covariant EditProfileCredentialsSection oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.initialName != widget.initialName) {
      _nameController.text = widget.initialName;
    }
    if (oldWidget.initialEmail != widget.initialEmail) {
      _emailController.text = widget.initialEmail;
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  void _handleSave() {
    if (_formKey.currentState?.validate() ?? false) {
      widget.onSave(
        name: _nameController.text.trim(),
        email: _emailController.text.trim(),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.margin),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(AppSpacing.margin),
        border: Border.all(color: AppColors.outlineVariant, width: 1.0),
      ),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'ACCOUNT CREDENTIALS',
                      style: AppTypography.labelCaps.copyWith(
                        color: AppColors.secondary,
                        letterSpacing: 1.2,
                      ),
                    ),
                    Text(
                      'Personal Information',
                      style: AppTypography.headlineSm.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
                const Icon(
                  Icons.badge_outlined,
                  color: AppColors.outline,
                  size: AppSpacing.spaceLg,
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.spaceMd),

            // Full Name Field
            Text(
              'FULL NAME',
              style: AppTypography.labelCaps.copyWith(
                color: AppColors.onSurfaceVariant,
                letterSpacing: 0.8,
              ),
            ),
            const SizedBox(height: AppSpacing.spaceXs),
            AuthTextFormField(
              controller: _nameController,
              hintText: 'Enter your full name',
              prefixIcon: Icons.person_outline_rounded,
              validator: ProfileValidators.validateName,
            ),
            const SizedBox(height: AppSpacing.spaceMd),

            // Email Address Field
            Text(
              'EMAIL ADDRESS',
              style: AppTypography.labelCaps.copyWith(
                color: AppColors.onSurfaceVariant,
                letterSpacing: 0.8,
              ),
            ),
            const SizedBox(height: AppSpacing.spaceXs),
            AuthTextFormField(
              controller: _emailController,
              hintText: 'Enter your email address',
              prefixIcon: Icons.mail_outline_rounded,
              keyboardType: TextInputType.emailAddress,
              validator: ProfileValidators.validateEmail,
            ),
            const SizedBox(height: AppSpacing.spaceLg),

            // Save Button
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                onPressed: widget.isLoading ? null : _handleSave,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(AppSpacing.spaceSm),
                  ),
                  elevation: 0,
                ),
                child: widget.isLoading
                    ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Colors.white,
                        ),
                      )
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.check_rounded, size: 18),
                          const SizedBox(width: AppSpacing.spaceSm),
                          Text(
                            'Save Changes',
                            style: AppTypography.bodyMd.copyWith(
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
