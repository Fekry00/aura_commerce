import 'package:aura/features/auth/presentation/utils/auth_validation_helper.dart';

/// Pure UI controller for VerifyNewPasswordSection isolating visibility toggles, security scores, and matching.
class VerifyNewPasswordSectionController {
  bool obscurePassword = true;
  bool obscureConfirm = true;

  void toggleObscurePassword() {
    obscurePassword = !obscurePassword;
  }

  void toggleObscureConfirm() {
    obscureConfirm = !obscureConfirm;
  }

  int getStrengthScore(String text) =>
      AuthValidationHelper.calculateSecurityScore(text);

  String getStrengthLabel(int score) =>
      AuthValidationHelper.getSecurityScoreLabel(score);

  bool isMatching(String password, String confirm) =>
      AuthValidationHelper.isMatching(password, confirm);
}
