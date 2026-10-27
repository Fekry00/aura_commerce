/// Pure calculation and validation logic helper for Auth feature
class AuthValidationHelper {
  const AuthValidationHelper._();

  /// Calculate password strength score (0-4) for ResetPasswordForm
  static int calculatePasswordStrength(String password) {
    int score = 0;
    if (password.length >= 8) score++;
    if (password.contains(RegExp(r'[A-Z]'))) score++;
    if (password.contains(RegExp(r'[0-9]'))) score++;
    if (password.contains(RegExp(r'[!@#\$&*~%^()]'))) score++;
    return score;
  }

  /// Calculate security password strength score (0-4) for VerifyNewPasswordSection
  static int calculateSecurityScore(String password) {
    if (password.isEmpty) return 0;
    return (password.length >= 6 ? 1 : 0) +
        (password.length >= 8 ? 1 : 0) +
        (password.contains(RegExp(r'[0-9]')) ? 1 : 0) +
        ((password.contains(RegExp(r'[!@#\$&*~%^()_\-+=<>?]')) ||
                password.contains(RegExp(r'[A-Z]')))
            ? 1
            : 0);
  }

  /// Get strength label for security score
  static String getSecurityScoreLabel(int score) {
    const labels = ['REQUIRED', 'WEAK', 'FAIR', 'GOOD', 'STRONG'];
    return labels[score.clamp(0, 4)];
  }

  /// Minimum characters rule check
  static bool hasMinChars(String password, [int min = 8]) =>
      password.length >= min;

  /// Contains at least one uppercase letter
  static bool hasUppercase(String password) =>
      password.contains(RegExp(r'[A-Z]'));

  /// Contains at least one digit
  static bool hasNumber(String password) =>
      password.contains(RegExp(r'[0-9]'));

  /// Contains at least one special character
  static bool hasSymbol(String password) => password
      .contains(RegExp(r'[!@#\$&*~%^()_\-+=<>?/{}[\]]'));

  /// Password confirmation match check
  static bool isMatching(String password, String confirmPassword) =>
      confirmPassword.isNotEmpty && confirmPassword == password;

  /// Valid email format pattern
  static bool isValidEmail(String email) {
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    return emailRegex.hasMatch(email.trim());
  }
}
