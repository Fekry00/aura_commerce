import 'package:aura/core/theme/app_colors.dart';
import 'package:aura/core/theme/app_typography.dart';
import 'package:aura/features/auth/presentation/widgets/auth_text_form_field.dart';
import 'package:flutter/material.dart';

class EditProfilePasswordSection extends StatefulWidget {
  final bool isLoading;
  final void Function({
    required String currentPassword,
    required String newPassword,
    required String newPasswordConfirmation,
  }) onUpdatePassword;

  const EditProfilePasswordSection({
    super.key,
    this.isLoading = false,
    required this.onUpdatePassword,
  });

  @override
  State<EditProfilePasswordSection> createState() =>
      _EditProfilePasswordSectionState();
}

class _EditProfilePasswordSectionState
    extends State<EditProfilePasswordSection> {
  final _formKey = GlobalKey<FormState>();
  final _currentPasswordController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  bool _isPanelOpen = false;
  bool _obscureCurrent = true;
  bool _obscureNew = true;
  bool _obscureConfirm = true;

  @override
  void dispose() {
    _currentPasswordController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _handleSubmit() {
    if (_formKey.currentState?.validate() ?? false) {
      widget.onUpdatePassword(
        currentPassword: _currentPasswordController.text,
        newPassword: _newPasswordController.text,
        newPasswordConfirmation: _confirmPasswordController.text,
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
                    'SECURITY VAULT',
                    style: AppTypography.labelCaps.copyWith(
                      color: AppColors.secondary,
                      letterSpacing: 1.2,
                    ),
                  ),
                  Text(
                    'Change Password',
                    style: AppTypography.headlineSm.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
              const Icon(
                Icons.lock_reset_rounded,
                color: AppColors.outline,
                size: AppSpacing.spaceLg,
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.spaceMd),

          InkWell(
            onTap: () => setState(() => _isPanelOpen = !_isPanelOpen),
            borderRadius: BorderRadius.circular(AppSpacing.margin),
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(
                vertical: AppSpacing.spaceSm + AppSpacing.spaceXs,
              ),
              decoration: BoxDecoration(
                color: AppColors.surfaceContainer,
                borderRadius: BorderRadius.circular(AppSpacing.margin),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    _isPanelOpen
                        ? Icons.keyboard_arrow_up_rounded
                        : Icons.security_rounded,
                    size: AppSpacing.spaceMd,
                    color: AppColors.secondary,
                  ),
                  const SizedBox(width: AppSpacing.spaceSm),
                  Text(
                    _isPanelOpen
                        ? 'Close Password Panel'
                        : 'Update Account Password',
                    style: AppTypography.bodyMd.copyWith(
                      fontWeight: FontWeight.w600,
                      color: AppColors.onSurface,
                    ),
                  ),
                ],
              ),
            ),
          ),

          if (_isPanelOpen) ...[
            const SizedBox(height: AppSpacing.spaceLg),
            Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Current Password
                  Text(
                    'CURRENT PASSWORD',
                    style: AppTypography.labelCaps.copyWith(
                      color: AppColors.onSurfaceVariant,
                      letterSpacing: 0.8,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.spaceXs),
                  AuthTextFormField(
                    controller: _currentPasswordController,
                    hintText: 'Enter current password',
                    obscureText: _obscureCurrent,
                    prefixIcon: Icons.lock_outline_rounded,
                    suffixWidget: IconButton(
                      icon: Icon(
                        _obscureCurrent
                            ? Icons.visibility_off_outlined
                            : Icons.visibility_outlined,
                        size: 20,
                        color: AppColors.outline,
                      ),
                      onPressed: () =>
                          setState(() => _obscureCurrent = !_obscureCurrent),
                    ),
                    validator: (val) {
                      if (val == null || val.isEmpty) {
                        return 'Current password is required';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: AppSpacing.spaceMd),

                  // New Password
                  Text(
                    'NEW PASSWORD',
                    style: AppTypography.labelCaps.copyWith(
                      color: AppColors.onSurfaceVariant,
                      letterSpacing: 0.8,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.spaceXs),
                  AuthTextFormField(
                    controller: _newPasswordController,
                    hintText: 'Minimum 8 characters',
                    obscureText: _obscureNew,
                    prefixIcon: Icons.key_rounded,
                    suffixWidget: IconButton(
                      icon: Icon(
                        _obscureNew
                            ? Icons.visibility_off_outlined
                            : Icons.visibility_outlined,
                        size: 20,
                        color: AppColors.outline,
                      ),
                      onPressed: () =>
                          setState(() => _obscureNew = !_obscureNew),
                    ),
                    validator: (val) {
                      if (val == null || val.isEmpty) {
                        return 'New password is required';
                      }
                      if (val.length < 8) {
                        return 'Password must be at least 8 characters';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: AppSpacing.spaceMd),

                  // Confirm New Password
                  Text(
                    'CONFIRM NEW PASSWORD',
                    style: AppTypography.labelCaps.copyWith(
                      color: AppColors.onSurfaceVariant,
                      letterSpacing: 0.8,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.spaceXs),
                  AuthTextFormField(
                    controller: _confirmPasswordController,
                    hintText: 'Re-enter new password',
                    obscureText: _obscureConfirm,
                    prefixIcon: Icons.check_circle_outline_rounded,
                    suffixWidget: IconButton(
                      icon: Icon(
                        _obscureConfirm
                            ? Icons.visibility_off_outlined
                            : Icons.visibility_outlined,
                        size: 20,
                        color: AppColors.outline,
                      ),
                      onPressed: () =>
                          setState(() => _obscureConfirm = !_obscureConfirm),
                    ),
                    validator: (val) {
                      if (val == null || val.isEmpty) {
                        return 'Please confirm your new password';
                      }
                      if (val != _newPasswordController.text) {
                        return 'Passwords do not match';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: AppSpacing.spaceLg),

                  // Submit Button
                  SizedBox(
                    width: double.infinity,
                    height: 48,
                    child: ElevatedButton(
                      onPressed: widget.isLoading ? null : _handleSubmit,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(AppSpacing.spaceSm),
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
                                const Icon(Icons.shield_outlined, size: 18),
                                const SizedBox(width: AppSpacing.spaceSm),
                                Text(
                                  'Update Password',
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
          ],
        ],
      ),
    );
  }
}
