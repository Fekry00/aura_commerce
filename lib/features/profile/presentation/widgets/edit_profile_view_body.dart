import 'package:aura/core/theme/app_colors.dart';
import 'package:aura/core/theme/app_typography.dart';
import 'package:aura/features/profile/presentation/controllers/edit_profile_controller.dart';
import 'package:aura/features/profile/presentation/cubit/profile_state.dart';
import 'package:aura/features/profile/presentation/widgets/edit_profile_avatar_section.dart';
import 'package:aura/features/profile/presentation/widgets/edit_profile_credentials_section.dart';
import 'package:aura/features/profile/presentation/widgets/edit_profile_password_section.dart';
import 'package:aura/features/profile/presentation/widgets/edit_profile_phone_section.dart';
import 'package:flutter/material.dart';

class EditProfileViewBody extends StatelessWidget {
  final ProfileState state;
  final EditProfileController controller;

  const EditProfileViewBody({
    super.key,
    required this.state,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    final profile = state.profile;
    final user = profile?.user;

    if (state is ProfileLoadingState && profile == null) {
      return const Center(
        child: CircularProgressIndicator(
          color: AppColors.secondary,
        ),
      );
    }

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.margin,
        vertical: AppSpacing.spaceMd,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Avatar Section
          EditProfileAvatarSection(
            avatarUrl: user?.avatarUrl,
            isLoading: state is ProfileAvatarLoadingState,
            onImageSelected: (path) =>
                controller.onImageSelected(context, path),
            onRemovePhoto: () => controller.onRemovePhoto(context),
          ),
          const SizedBox(height: AppSpacing.spaceLg),

          // Name & Email Section
          EditProfileCredentialsSection(
            initialName: user?.name ?? '',
            initialEmail: user?.email ?? '',
            isLoading: state is ProfileUpdatingState,
            controller: controller,
            onSave: ({required name, required email}) =>
                controller.onSaveCredentials(context,
                    name: name, email: email),
          ),
          const SizedBox(height: AppSpacing.spaceMd),

          // Phone OTP Section
          EditProfilePhoneSection(
            initialPhoneNumber: user?.phone ?? '',
            onSendOtp: (phone) =>
                controller.onSendPhoneOtp(context, phone),
            onVerifyOtp: (phone, otp) =>
                controller.onVerifyPhoneOtp(context, phone, otp),
          ),
          const SizedBox(height: AppSpacing.spaceMd),

          // Password Section
          EditProfilePasswordSection(
            isLoading: state is ProfilePasswordChangingState,
            controller: controller,
            onUpdatePassword: ({
              required currentPassword,
              required newPassword,
              required newPasswordConfirmation,
            }) =>
                controller.onUpdatePassword(
              context,
              currentPassword: currentPassword,
              newPassword: newPassword,
              newPasswordConfirmation: newPasswordConfirmation,
            ),
          ),
          const SizedBox(height: AppSpacing.spaceLg),

          // Danger Zone: Delete Account
          Center(
            child: TextButton.icon(
              onPressed: state is ProfileAccountDeletingState
                  ? null
                  : () => controller.onDeleteAccountPressed(context),
              icon: state is ProfileAccountDeletingState
                  ? const SizedBox(
                      width: 16,
                      height: 16,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: AppColors.error,
                      ),
                    )
                  : const Icon(
                      Icons.delete_forever_outlined,
                      color: AppColors.error,
                      size: 18,
                    ),
              label: Text(
                'Delete Aura Account',
                style: AppTypography.bodySm.copyWith(
                  color: AppColors.error,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.spaceXl),
        ],
      ),
    );
  }
}
