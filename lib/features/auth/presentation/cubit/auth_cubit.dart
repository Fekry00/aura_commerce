import 'package:aura/features/auth/domain/usecases/auth_change_password_usecase.dart';
import 'package:aura/features/auth/domain/usecases/forgot_password_usecase.dart';
import 'package:aura/features/auth/domain/usecases/logout_usecase.dart';
import 'package:aura/features/auth/domain/usecases/refresh_token_usecase.dart';
import 'package:aura/features/auth/domain/usecases/resend_otp_usecase.dart';
import 'package:aura/features/auth/domain/usecases/reset_password_usecase.dart';
import 'package:aura/features/auth/domain/usecases/sign_in_usecase.dart';
import 'package:aura/features/auth/domain/usecases/sign_up_usecase.dart';
import 'package:aura/features/auth/domain/usecases/verify_reset_otp_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit({
    required this.signInUseCase,
    required this.signUpUseCase,
    required this.forgotPasswordUseCase,
    required this.resendOtpUseCase,
    required this.verifyResetOtpUseCase,
    required this.resetPasswordUseCase,
    required this.refreshTokenUseCase,
    required this.logoutUseCase,
    required this.changePasswordUseCase,
  }) : super(const AuthInitialState());

  final SignInUseCase signInUseCase;
  final SignUpUseCase signUpUseCase;
  final ForgotPasswordUseCase forgotPasswordUseCase;
  final ResendOtpUseCase resendOtpUseCase;
  final VerifyResetOtpUseCase verifyResetOtpUseCase;
  final ResetPasswordUseCase resetPasswordUseCase;
  final RefreshTokenUseCase refreshTokenUseCase;
  final LogoutUseCase logoutUseCase;
  final AuthChangePasswordUseCase changePasswordUseCase;

  Future<void> signIn({
    required String email,
    required String password,
    bool rememberDevice = true,
  }) async {
    emit(const AuthLoadingState());

    final result = await signInUseCase(
      email: email,
      password: password,
      rememberDevice: rememberDevice,
    );

    result.fold(
      (failure) => emit(AuthErrorState(message: failure.errMessage)),
      (auth) => emit(AuthSuccessState(auth: auth)),
    );
  }

  Future<void> signUp({
    required String name,
    required String email,
    required String phone,
    required String password,
  }) async {
    emit(const AuthLoadingState());

    final result = await signUpUseCase(
      name: name,
      email: email,
      phone: phone,
      password: password,
    );

    result.fold(
      (failure) => emit(AuthErrorState(message: failure.errMessage)),
      (auth) => emit(AuthSuccessState(auth: auth)),
    );
  }

  /// Step 1: Send OTP to the given email.
  Future<void> forgotPassword({required String email}) async {
    emit(const AuthLoadingState());

    final result = await forgotPasswordUseCase(email: email);

    result.fold(
      (failure) => emit(AuthErrorState(message: failure.errMessage)),
      (_) => emit(const AuthOtpSentState()),
    );
  }

  /// Step 2 (optional): Resend OTP to the same email.
  Future<void> resendOtp({required String email}) async {
    emit(const AuthLoadingState());

    final result = await resendOtpUseCase(email: email);

    result.fold(
      (failure) => emit(AuthErrorState(message: failure.errMessage)),
      (_) => emit(const AuthOtpSentState()),
    );
  }

  /// Step 3: Verify OTP.
  Future<void> verifyResetOtp({required String otp}) async {
    emit(const AuthLoadingState());

    final result = await verifyResetOtpUseCase(otp: otp);

    result.fold(
      (failure) => emit(AuthErrorState(message: failure.errMessage)),
      (_) => emit(const AuthOtpVerifiedState()),
    );
  }

  /// Step 4: Set the new password.
  Future<void> resetPassword({
    required String otp,
    required String newPassword,
  }) async {
    emit(const AuthLoadingState());

    final result = await resetPasswordUseCase(
      otp: otp,
      newPassword: newPassword,
    );

    result.fold(
      (failure) => emit(AuthErrorState(message: failure.errMessage)),
      (_) => emit(const AuthPasswordResetSuccessState()),
    );
  }

  /// Refresh token
  Future<void> refreshToken() async {
    emit(const AuthLoadingState());

    final result = await refreshTokenUseCase();

    result.fold(
      (failure) => emit(AuthErrorState(message: failure.errMessage)),
      (auth) => emit(AuthTokenRefreshedState(auth: auth)),
    );
  }

  /// Logout from server and clear local session
  Future<void> logout() async {
    emit(const AuthLoadingState());

    final result = await logoutUseCase();

    result.fold(
      (failure) => emit(const AuthLoggedOutState()),
      (_) => emit(const AuthLoggedOutState()),
    );
  }

  /// Change Password (If Logged In)
  Future<void> changePassword({
    required String currentPassword,
    required String newPassword,
    required String newPasswordConfirmation,
  }) async {
    emit(const AuthLoadingState());

    final result = await changePasswordUseCase(
      currentPassword: currentPassword,
      newPassword: newPassword,
      newPasswordConfirmation: newPasswordConfirmation,
    );

    result.fold(
      (failure) => emit(AuthErrorState(message: failure.errMessage)),
      (_) => emit(const AuthPasswordChangedState()),
    );
  }
}
