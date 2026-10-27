import 'package:aura/features/auth/presentation/utils/auth_validation_helper.dart';

/// Pure UI controller for passphrase input fields, visibility toggles, and validations.
class AuthPassphraseController {
  bool obscurePassword = true;
  bool obscureConfirmPassword = true;

  void toggleObscurePassword() {
    obscurePassword = !obscurePassword;
  }

  void toggleObscureConfirmPassword() {
    obscureConfirmPassword = !obscureConfirmPassword;
  }

  bool hasMinChars(String text) => AuthValidationHelper.hasMinChars(text);

  bool hasNumber(String text) => AuthValidationHelper.hasNumber(text);

  bool hasSymbol(String text) => AuthValidationHelper.hasSymbol(text);

  bool isStrong(String text) =>
      hasMinChars(text) && hasNumber(text) && hasSymbol(text);

  bool isMatching(String password, String confirm) =>
      AuthValidationHelper.isMatching(password, confirm);

  String? validatePassword(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Password is required';
    }
    if (value.length < 8) {
      return 'Password must be at least 8 characters';
    }
    return null;
  }

  String? validateConfirmPassword(String? value, String password) {
    if (value == null || value.trim().isEmpty) {
      return 'Please confirm your password';
    }
    if (value != password) {
      return 'Passwords do not match';
    }
    return null;
  }
}
