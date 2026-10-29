import 'package:aura/core/theme/app_colors.dart';
import 'package:aura/core/theme/app_typography.dart';
import 'package:aura/features/profile/presentation/cubit/profile_cubit.dart';
import 'package:aura/features/profile/presentation/cubit/profile_state.dart';
import 'package:aura/features/profile/presentation/widgets/edit_profile_avatar_section.dart';
import 'package:aura/features/profile/presentation/widgets/edit_profile_credentials_section.dart';
import 'package:aura/features/profile/presentation/widgets/edit_profile_delete_dialog.dart';
import 'package:aura/features/profile/presentation/widgets/edit_profile_password_section.dart';
import 'package:aura/features/profile/presentation/widgets/edit_profile_phone_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EditProfileViewBody extends StatelessWidget {
  final ProfileState state;

  const EditProfileViewBody({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    final profile = state.profile;
    final user = profile?.user;

    if (state is ProfileLoadingState && profile == null) {
      return const Center(child: CircularProgressIndicator(color: AppColors.secondary));
    }

    final cubit = context.read<ProfileCubit>();

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.margin, vertical: AppSpacing.spaceMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          EditProfileAvatarSection(
            avatarUrl: user?.avatarUrl,
            isLoading: state is ProfileAvatarLoadingState,
            onImageSelected: (path) => cubit.updateAvatar(imagePath: path),
            onRemovePhoto: cubit.deleteAvatar,
          ),
          const SizedBox(height: AppSpacing.spaceLg),
          EditProfileCredentialsSection(
            initialName: user?.name ?? '',
            initialEmail: user?.email ?? '',
            isLoading: state is ProfileUpdatingState,
            onSave: ({required name, required email}) => cubit.updateProfile(name: name, email: email),
          ),
          const SizedBox(height: AppSpacing.spaceMd),
          EditProfilePhoneSection(
            initialPhoneNumber: user?.phone ?? '',
            onSendOtp: (phone) => cubit.sendPhoneOtp(phone: phone),
            onVerifyOtp: (phone, otp) => cubit.verifyPhoneOtp(phone: phone, otp: otp),
          ),
          const SizedBox(height: AppSpacing.spaceMd),
          EditProfilePasswordSection(
            isLoading: state is ProfilePasswordChangingState,
            onUpdatePassword: ({required currentPassword, required newPassword, required newPasswordConfirmation}) =>
                cubit.changePassword(
              currentPassword: currentPassword,
              newPassword: newPassword,
              newPasswordConfirmation: newPasswordConfirmation,
            ),
          ),
          const SizedBox(height: AppSpacing.spaceLg),
          Center(
            child: TextButton.icon(
              onPressed: state is ProfileAccountDeletingState
                  ? null
                  : () => EditProfileDeleteDialog.show(
                        context,
                        onConfirmDelete: (pw) => cubit.deleteAccount(password: pw),
                      ),
              icon: state is ProfileAccountDeletingState
                  ? const SizedBox(
                      width: 16,
                      height: 16,
                      child: CircularProgressIndicator(strokeWidth: 2, color: AppColors.error),
                    )
                  : const Icon(Icons.delete_forever_outlined, color: AppColors.error, size: 18),
              label: Text(
                'Delete Aura Account',
                style: AppTypography.bodySm.copyWith(color: AppColors.error, fontWeight: FontWeight.w600),
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.spaceXl),
        ],
      ),
    );
  }
}
