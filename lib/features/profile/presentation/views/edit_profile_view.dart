import 'package:aura/core/routing/routes.dart';
import 'package:aura/core/theme/app_colors.dart';
import 'package:aura/core/theme/app_typography.dart';
import 'package:aura/core/utils/functions/custom_snack_bar.dart';
import 'package:aura/features/profile/presentation/cubit/profile_cubit.dart';
import 'package:aura/features/profile/presentation/cubit/profile_state.dart';
import 'package:aura/features/profile/presentation/widgets/edit_profile_avatar_section.dart';
import 'package:aura/features/profile/presentation/widgets/edit_profile_credentials_section.dart';
import 'package:aura/features/profile/presentation/widgets/edit_profile_password_section.dart';
import 'package:aura/features/profile/presentation/widgets/edit_profile_phone_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EditProfileView extends StatelessWidget {
  const EditProfileView({super.key});

  void _showDeleteAccountDialog(BuildContext context) {
    final passwordController = TextEditingController();
    final formKey = GlobalKey<FormState>();

    showDialog(
      context: context,
      builder: (dialogCtx) {
        return AlertDialog(
          backgroundColor: AppColors.surfaceContainerLowest,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSpacing.margin),
          ),
          title: Row(
            children: [
              const Icon(Icons.warning_amber_rounded, color: AppColors.error),
              const SizedBox(width: AppSpacing.spaceSm),
              Text(
                'Delete Account',
                style: AppTypography.headlineSm.copyWith(
                  fontWeight: FontWeight.w700,
                  color: AppColors.error,
                ),
              ),
            ],
          ),
          content: Form(
            key: formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'This action is irreversible. All your concierge records, active orders, and membership points will be permanently erased.',
                  style: AppTypography.bodySm.copyWith(
                    color: AppColors.slateBody,
                  ),
                ),
                const SizedBox(height: AppSpacing.spaceMd),
                Text(
                  'CONFIRM WITH PASSWORD',
                  style: AppTypography.labelCaps.copyWith(
                    color: AppColors.onSurfaceVariant,
                  ),
                ),
                const SizedBox(height: AppSpacing.spaceXs),
                TextFormField(
                  controller: passwordController,
                  obscureText: true,
                  style: AppTypography.bodySm,
                  decoration: InputDecoration(
                    hintText: 'Enter your password',
                    filled: true,
                    fillColor: AppColors.surfaceContainerLow,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(AppSpacing.spaceSm),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  validator: (val) {
                    if (val == null || val.isEmpty) {
                      return 'Password is required to delete account';
                    }
                    return null;
                  },
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogCtx),
              child: Text(
                'Cancel',
                style: AppTypography.bodyMd.copyWith(
                  color: AppColors.onSurfaceVariant,
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                if (formKey.currentState?.validate() ?? false) {
                  final pwd = passwordController.text;
                  Navigator.pop(dialogCtx);
                  context.read<ProfileCubit>().deleteAccount(password: pwd);
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.error,
                foregroundColor: Colors.white,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppSpacing.spaceSm),
                ),
              ),
              child: const Text('Confirm Delete'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfileCubit, ProfileState>(
      listener: (context, state) {
        if (state is ProfileUpdateSuccessState) {
          showCustomSnackBar(context,
              message: state.message, type: SnackBarType.success);
        } else if (state is ProfileUpdateErrorState) {
          showCustomSnackBar(context,
              message: state.message, type: SnackBarType.error);
        } else if (state is ProfileAvatarSuccessState) {
          showCustomSnackBar(context,
              message: state.message, type: SnackBarType.success);
        } else if (state is ProfileAvatarErrorState) {
          showCustomSnackBar(context,
              message: state.message, type: SnackBarType.error);
        } else if (state is ProfilePhoneOtpSentState) {
          showCustomSnackBar(context,
              message: state.message, type: SnackBarType.info);
        } else if (state is ProfilePhoneVerifiedState) {
          showCustomSnackBar(context,
              message: state.message, type: SnackBarType.success);
        } else if (state is ProfilePhoneErrorState) {
          showCustomSnackBar(context,
              message: state.message, type: SnackBarType.error);
        } else if (state is ProfilePasswordChangedState) {
          showCustomSnackBar(context,
              message: state.message, type: SnackBarType.success);
        } else if (state is ProfilePasswordErrorState) {
          showCustomSnackBar(context,
              message: state.message, type: SnackBarType.error);
        } else if (state is ProfileAccountDeleteErrorState) {
          showCustomSnackBar(context,
              message: state.message, type: SnackBarType.error);
        } else if (state is ProfileAccountDeletedState ||
            state is ProfileSignedOutState) {
          Navigator.pushNamedAndRemoveUntil(
            context,
            Routes.signInView,
            (route) => false,
          );
        }
      },
      builder: (context, state) {
        final profile = state.profile;
        final user = profile?.user;

        return Scaffold(
          backgroundColor: AppColors.background,
          appBar: AppBar(
            backgroundColor: AppColors.background,
            elevation: 0,
            leading: IconButton(
              icon: const Icon(
                Icons.arrow_back_ios_new_rounded,
                color: AppColors.onSurface,
                size: 20,
              ),
              onPressed: () => Navigator.pop(context),
            ),
            centerTitle: true,
            title: Text(
              'EDIT PROFILE',
              style: AppTypography.labelCaps.copyWith(
                color: AppColors.primary,
                letterSpacing: 1.5,
                fontWeight: FontWeight.w700,
                fontSize: 13,
              ),
            ),
          ),
          body: (state is ProfileLoadingState && profile == null)
              ? const Center(
                  child: CircularProgressIndicator(
                    color: AppColors.secondary,
                  ),
                )
              : SingleChildScrollView(
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
                        onImageSelected: (path) {
                          context
                              .read<ProfileCubit>()
                              .updateAvatar(imagePath: path);
                        },
                        onRemovePhoto: () {
                          context.read<ProfileCubit>().deleteAvatar();
                        },
                      ),
                      const SizedBox(height: AppSpacing.spaceLg),

                      // Name & Email Section
                      EditProfileCredentialsSection(
                        initialName: user?.name ?? '',
                        initialEmail: user?.email ?? '',
                        isLoading: state is ProfileUpdatingState,
                        onSave: ({required name, required email}) {
                          context
                              .read<ProfileCubit>()
                              .updateProfile(name: name, email: email);
                        },
                      ),
                      const SizedBox(height: AppSpacing.spaceMd),

                      // Phone OTP Section
                      EditProfilePhoneSection(
                        initialPhoneNumber: user?.phone ?? '',
                        onSendOtp: (phone) => context
                            .read<ProfileCubit>()
                            .sendPhoneOtp(phone: phone),
                        onVerifyOtp: (phone, otp) => context
                            .read<ProfileCubit>()
                            .verifyPhoneOtp(phone: phone, otp: otp),
                      ),
                      const SizedBox(height: AppSpacing.spaceMd),

                      // Password Section
                      EditProfilePasswordSection(
                        isLoading: state is ProfilePasswordChangingState,
                        onUpdatePassword: ({
                          required currentPassword,
                          required newPassword,
                          required newPasswordConfirmation,
                        }) {
                          context.read<ProfileCubit>().changePassword(
                                currentPassword: currentPassword,
                                newPassword: newPassword,
                                newPasswordConfirmation:
                                    newPasswordConfirmation,
                              );
                        },
                      ),
                      const SizedBox(height: AppSpacing.spaceLg),

                      // Danger Zone: Delete Account
                      Center(
                        child: TextButton.icon(
                          onPressed: state is ProfileAccountDeletingState
                              ? null
                              : () => _showDeleteAccountDialog(context),
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
                ),
        );
      },
    );
  }
}
