import 'package:aura/features/auth/domain/entities/auth_entity.dart';

abstract class AuthState {
  const AuthState();
}

class AuthInitialState extends AuthState {
  const AuthInitialState();
}

class AuthLoadingState extends AuthState {
  const AuthLoadingState();
}

class AuthSuccessState extends AuthState {
  const AuthSuccessState({required this.auth});

  final AuthEntity auth;
}

/// Emitted after forgot-password OTP is sent successfully.
class AuthOtpSentState extends AuthState {
  const AuthOtpSentState();
}

/// Emitted after OTP is verified successfully (before setting new password).
class AuthOtpVerifiedState extends AuthState {
  const AuthOtpVerifiedState();
}

/// Emitted after new password is set successfully.
class AuthPasswordResetSuccessState extends AuthState {
  final String message;
  const AuthPasswordResetSuccessState({
    this.message = 'Password reset successfully. Please sign in.',
  });
}

/// Emitted for informational messages (e.g. Concierge connecting, Face ID).
class AuthInfoMessageState extends AuthState {
  final String message;
  const AuthInfoMessageState({required this.message});
}

/// Emitted after successful logout.
class AuthLoggedOutState extends AuthState {
  const AuthLoggedOutState();
}

/// Emitted after password is changed successfully.
class AuthPasswordChangedState extends AuthState {
  const AuthPasswordChangedState({this.message = 'تم تغيير كلمة المرور بنجاح'});

  final String message;
}

/// Emitted after token is refreshed successfully.
class AuthTokenRefreshedState extends AuthState {
  const AuthTokenRefreshedState({required this.auth});

  final AuthEntity auth;
}

class AuthErrorState extends AuthState {
  const AuthErrorState({required this.message});

  final String message;
}

