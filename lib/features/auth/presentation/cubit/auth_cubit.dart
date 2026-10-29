import 'dart:async';
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

  String? resetEmail;
  Timer? _otpTimer;
  int _otpSecondsRemaining = 120;
  bool _canResendOtp = false;

  int get otpSecondsRemaining => _otpSecondsRemaining;
  bool get canResendOtp => _canResendOtp;
  String get formattedOtpTimer {
    final m = (_otpSecondsRemaining ~/ 60).toString().padLeft(2, '0');
    final s = (_otpSecondsRemaining % 60).toString().padLeft(2, '0');
    return '$m:$s';
  }

  void startOtpTimer({int duration = 120}) {
    _otpTimer?.cancel();
    _otpSecondsRemaining = duration;
    _canResendOtp = false;
    emit(AuthOtpTimerTickState(
      secondsRemaining: _otpSecondsRemaining,
      canResend: _canResendOtp,
      formattedTimer: formattedOtpTimer,
    ));

    _otpTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_otpSecondsRemaining <= 1) {
        timer.cancel();
        _otpSecondsRemaining = 0;
        _canResendOtp = true;
        emit(const AuthOtpTimerTickState(
          secondsRemaining: 0,
          canResend: true,
          formattedTimer: '00:00',
        ));
      } else {
        _otpSecondsRemaining--;
        emit(AuthOtpTimerTickState(
          secondsRemaining: _otpSecondsRemaining,
          canResend: false,
          formattedTimer: formattedOtpTimer,
        ));
      }
    });
  }

  void stopOtpTimer() {
    _otpTimer?.cancel();
    _otpTimer = null;
  }

  @override
  void emit(AuthState state) {
    if (!isClosed) {
      super.emit(state);
    }
  }

  @override
  Future<void> close() {
    _otpTimer?.cancel();
    return super.close();
  }

  Future<void> signIn({
    required String email,
    required String password,
    bool rememberDevice = true,
    bool isFormValid = true,
  }) async {
    if (!isFormValid || email.trim().isEmpty || password.isEmpty) {
      emit(const AuthErrorState(message: 'Email and password are required'));
      return;
    }

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
    String? confirmPassword,
    bool isFormValid = true,
  }) async {
    if (!isFormValid || name.trim().isEmpty || email.trim().isEmpty || phone.trim().isEmpty || password.isEmpty) {
      emit(const AuthErrorState(message: 'Please fill in all required fields properly.'));
      return;
    }

    if (confirmPassword != null && password != confirmPassword) {
      emit(const AuthErrorState(message: 'Passwords do not match.'));
      return;
    }

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
  Future<void> forgotPassword({
    required String email,
    bool isFormValid = true,
  }) async {
    if (!isFormValid || email.trim().isEmpty) {
      emit(const AuthErrorState(message: 'Email address is required'));
      return;
    }

    resetEmail = email.trim();
    emit(const AuthLoadingState());

    final result = await forgotPasswordUseCase(email: email);

    result.fold(
      (failure) => emit(AuthErrorState(message: failure.errMessage)),
      (_) {
        startOtpTimer();
        emit(const AuthOtpSentState());
      },
    );
  }

  /// Step 2 (optional): Resend OTP to the same email.
  Future<void> resendOtp({required String email}) async {
    resetEmail = email.trim();
    emit(const AuthLoadingState());

    final result = await resendOtpUseCase(email: email);

    result.fold(
      (failure) => emit(AuthErrorState(message: failure.errMessage)),
      (_) {
        startOtpTimer();
        emit(const AuthOtpSentState());
      },
    );
  }

  /// Step 3: Verify OTP.
  Future<void> verifyResetOtp({required String otp, String? email}) async {
    if (otp.length < 6) {
      emit(const AuthErrorState(message: 'Please enter all 6 digits.'));
      return;
    }

    final targetEmail = email ?? resetEmail;
    emit(const AuthLoadingState());

    final result = await verifyResetOtpUseCase(otp: otp, email: targetEmail);

    result.fold(
      (failure) => emit(AuthErrorState(message: failure.errMessage)),
      (_) => emit(const AuthOtpVerifiedState()),
    );
  }

  /// Step 4: Set the new password.
  Future<void> resetPassword({
    required String otp,
    required String newPassword,
    String? confirmPassword,
    String? email,
    bool isFormValid = true,
  }) async {
    if (!isFormValid) {
      emit(const AuthErrorState(message: 'Please check your inputs.'));
      return;
    }
    if (otp.length < 6) {
      emit(const AuthErrorState(message: 'Please enter all 6 digits of the keycode.'));
      return;
    }
    if (newPassword.length < 8) {
      emit(const AuthErrorState(message: 'Password must be at least 8 characters.'));
      return;
    }
    if (confirmPassword != null && newPassword != confirmPassword) {
      emit(const AuthErrorState(message: 'Passwords do not match.'));
      return;
    }

    final targetEmail = email ?? resetEmail;
    emit(const AuthLoadingState());

    final result = await resetPasswordUseCase(
      otp: otp,
      newPassword: newPassword,
      email: targetEmail,
    );

    result.fold(
      (failure) => emit(AuthErrorState(message: failure.errMessage)),
      (_) => emit(const AuthPasswordResetSuccessState(
        message: 'Password reset successfully! Welcome to Atelier Vault.',
      )),
    );
  }

  /// Trigger biometric Face ID authentication
  void authenticateBiometric() {
    emit(const AuthInfoMessageState(message: 'Authenticating Face ID...'));
  }

  /// Connect to Atelier Concierge
  void connectConcierge() {
    emit(const AuthInfoMessageState(message: 'Connecting to Concierge...'));
  }

  /// Lock account for security
  void lockAccount() {
    emit(const AuthErrorState(message: 'Account locked for security.'));
  }

  /// Dispatches keycode resend notification
  void dispatchKeycode() {
    startOtpTimer(duration: 40);
    emit(const AuthInfoMessageState(message: 'New keycode dispatched.'));
  }

  /// Dispatches keycode via SMS notification
  void dispatchKeycodeSms() {
    startOtpTimer(duration: 40);
    emit(const AuthInfoMessageState(message: 'Authorization keycode dispatched via SMS.'));
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
