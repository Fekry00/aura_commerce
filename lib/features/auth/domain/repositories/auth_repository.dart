import 'package:aura/core/errors/failure.dart';
import 'package:aura/features/auth/domain/entities/auth_entity.dart';
import 'package:dartz/dartz.dart';

abstract class AuthRepository {
  Future<Either<Failure, AuthEntity>> signIn({
    required String email,
    required String password,
    bool rememberDevice = true,
  });

  Future<Either<Failure, AuthEntity>> signUp({
    required String name,
    required String email,
    required String phone,
    required String password,
  });

  /// Step 1: Send OTP to email.
  Future<Either<Failure, bool>> forgotPassword({required String email});

  /// Step 2 (optional): Resend OTP.
  Future<Either<Failure, bool>> resendOtp({required String email});

  /// Step 3: Verify OTP — returns true if valid.
  Future<Either<Failure, bool>> verifyResetOtp({
    required String otp,
    String? email,
  });

  /// Step 4: Set new password.
  Future<Either<Failure, bool>> resetPassword({
    required String otp,
    required String newPassword,
    String? email,
  });

  Future<Either<Failure, AuthEntity?>> getSavedAuthSession();

  Future<Either<Failure, bool>> signOut();

  Future<Either<Failure, AuthEntity>> refreshToken();

  Future<Either<Failure, bool>> logout();

  Future<Either<Failure, bool>> changePassword({
    required String currentPassword,
    required String newPassword,
    required String newPasswordConfirmation,
  });
}
