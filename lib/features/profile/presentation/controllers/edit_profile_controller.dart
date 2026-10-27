import 'package:aura/features/profile/presentation/cubit/profile_cubit.dart';
import 'package:aura/features/profile/presentation/widgets/edit_profile_delete_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Pure UI controller for Edit Profile actions, delegations, and dialogs.
class EditProfileController {
  const EditProfileController();

  void onImageSelected(BuildContext context, String path) {
    context.read<ProfileCubit>().updateAvatar(imagePath: path);
  }

  void onRemovePhoto(BuildContext context) {
    context.read<ProfileCubit>().deleteAvatar();
  }

  void onSaveCredentials(
    BuildContext context, {
    required String name,
    required String email,
  }) {
    context.read<ProfileCubit>().updateProfile(name: name, email: email);
  }

  Future<void> onSendPhoneOtp(BuildContext context, String phone) async {
    await context.read<ProfileCubit>().sendPhoneOtp(phone: phone);
  }

  Future<void> onVerifyPhoneOtp(
    BuildContext context,
    String phone,
    String otp,
  ) async {
    await context.read<ProfileCubit>().verifyPhoneOtp(phone: phone, otp: otp);
  }

  void onUpdatePassword(
    BuildContext context, {
    required String currentPassword,
    required String newPassword,
    required String newPasswordConfirmation,
  }) {
    context.read<ProfileCubit>().changePassword(
          currentPassword: currentPassword,
          newPassword: newPassword,
          newPasswordConfirmation: newPasswordConfirmation,
        );
  }

  void onDeleteAccountPressed(BuildContext context) {
    EditProfileDeleteDialog.show(
      context,
      onConfirmDelete: (password) => onDeleteAccount(context, password),
    );
  }

  void onDeleteAccount(BuildContext context, String password) {
    context.read<ProfileCubit>().deleteAccount(password: password);
  }

  String? validateName(String? val) {
    if (val == null || val.trim().isEmpty) return 'Name cannot be empty';
    return null;
  }

  String? validateEmail(String? val) {
    if (val == null || val.trim().isEmpty) return 'Email cannot be empty';
    if (!val.contains('@') || !val.contains('.')) return 'Invalid email address';
    return null;
  }

  String? validateCurrentPassword(String? val) {
    if (val == null || val.isEmpty) return 'Current password is required';
    return null;
  }

  String? validateNewPassword(String? val) {
    if (val == null || val.isEmpty) return 'New password is required';
    if (val.length < 8) return 'Password must be at least 8 characters';
    return null;
  }

  String? validateConfirmPassword(String? val, String newPassword) {
    if (val == null || val.isEmpty) return 'Please confirm your new password';
    if (val != newPassword) return 'Passwords do not match';
    return null;
  }

  String? validatePhone(String? val) {
    if (val == null || val.trim().isEmpty) return 'Phone number is required';
    return null;
  }
}
