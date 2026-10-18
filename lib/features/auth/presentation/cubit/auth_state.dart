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

class AuthOtpSentState extends AuthState {
  const AuthOtpSentState();
}

class AuthPasswordResetSuccessState extends AuthState {
  const AuthPasswordResetSuccessState();
}

class AuthErrorState extends AuthState {
  const AuthErrorState({required this.message});

  final String message;
}
