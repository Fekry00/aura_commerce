import 'package:aura/features/auth/domain/usecases/send_reset_otp_usecase.dart';
import 'package:aura/features/auth/domain/usecases/sign_in_usecase.dart';
import 'package:aura/features/auth/domain/usecases/sign_up_usecase.dart';
import 'package:aura/features/auth/domain/usecases/verify_reset_password_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit({
    required this.signInUseCase,
    required this.signUpUseCase,
    required this.verifyResetPasswordUseCase,
    required this.sendResetOtpUseCase,
  }) : super(const AuthInitialState());

  final SignInUseCase signInUseCase;
  final SignUpUseCase signUpUseCase;
  final VerifyResetPasswordUseCase verifyResetPasswordUseCase;
  final SendResetOtpUseCase sendResetOtpUseCase;

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

  Future<void> verifyResetPassword({
    required String otp,
    required String newPassword,
  }) async {
    emit(const AuthLoadingState());

    final result = await verifyResetPasswordUseCase(
      otp: otp,
      newPassword: newPassword,
    );

    result.fold(
      (failure) => emit(AuthErrorState(message: failure.errMessage)),
      (_) => emit(const AuthPasswordResetSuccessState()),
    );
  }

  Future<void> sendResetOtp({required String email}) async {
    emit(const AuthLoadingState());

    final result = await sendResetOtpUseCase(email: email);

    result.fold(
      (failure) => emit(AuthErrorState(message: failure.errMessage)),
      (_) => emit(const AuthOtpSentState()),
    );
  }
}
