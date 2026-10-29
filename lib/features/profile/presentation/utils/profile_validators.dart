import 'package:aura/core/utils/app_constants.dart';

class ProfileValidators {
  const ProfileValidators._();

  static String? validateName(String? val) {
    if (val == null || val.trim().isEmpty) return 'Name cannot be empty';
    return null;
  }

  static String? validateEmail(String? val) {
    if (val == null || val.trim().isEmpty) return 'Email cannot be empty';
    if (!AppConstants.emailRegex.hasMatch(val.trim())) {
      return 'Invalid email address';
    }
    return null;
  }

  static String? validateCurrentPassword(String? val) {
    if (val == null || val.isEmpty) return 'Current password is required';
    return null;
  }

  static String? validateNewPassword(String? val) {
    if (val == null || val.isEmpty) return 'New password is required';
    if (val.length < 8) return 'Password must be at least 8 characters';
    return null;
  }

  static String? validateConfirmPassword(String? val, String newPassword) {
    if (val == null || val.isEmpty) return 'Please confirm your new password';
    if (val != newPassword) return 'Passwords do not match';
    return null;
  }

  static String? validatePhone(String? val) {
    if (val == null || val.trim().isEmpty) return 'Phone number is required';
    if (!AppConstants.phoneRegex.hasMatch(val.trim())) {
      return 'Invalid phone number';
    }
    return null;
  }
}
