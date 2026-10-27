import 'package:aura/core/routing/routes.dart';
import 'package:aura/core/utils/functions/custom_snack_bar.dart';
import 'package:aura/features/profile/presentation/cubit/profile_state.dart';
import 'package:flutter/material.dart';

class EditProfileListenerHandler {
  const EditProfileListenerHandler._();

  static void handleState(BuildContext context, ProfileState state) {
    if (state is ProfileUpdateSuccessState) {
      showCustomSnackBar(
        context,
        message: state.message,
        type: SnackBarType.success,
      );
    } else if (state is ProfileUpdateErrorState) {
      showCustomSnackBar(
        context,
        message: state.message,
        type: SnackBarType.error,
      );
    } else if (state is ProfileAvatarSuccessState) {
      showCustomSnackBar(
        context,
        message: state.message,
        type: SnackBarType.success,
      );
    } else if (state is ProfileAvatarErrorState) {
      showCustomSnackBar(
        context,
        message: state.message,
        type: SnackBarType.error,
      );
    } else if (state is ProfilePhoneOtpSentState) {
      showCustomSnackBar(
        context,
        message: state.message,
        type: SnackBarType.info,
      );
    } else if (state is ProfilePhoneVerifiedState) {
      showCustomSnackBar(
        context,
        message: state.message,
        type: SnackBarType.success,
      );
    } else if (state is ProfilePhoneErrorState) {
      showCustomSnackBar(
        context,
        message: state.message,
        type: SnackBarType.error,
      );
    } else if (state is ProfilePasswordChangedState) {
      showCustomSnackBar(
        context,
        message: state.message,
        type: SnackBarType.success,
      );
    } else if (state is ProfilePasswordErrorState) {
      showCustomSnackBar(
        context,
        message: state.message,
        type: SnackBarType.error,
      );
    } else if (state is ProfileAccountDeleteErrorState) {
      showCustomSnackBar(
        context,
        message: state.message,
        type: SnackBarType.error,
      );
    } else if (state is ProfileAccountDeletedState ||
        state is ProfileSignedOutState) {
      Navigator.pushNamedAndRemoveUntil(
        context,
        Routes.signInView,
        (route) => false,
      );
    }
  }
}
