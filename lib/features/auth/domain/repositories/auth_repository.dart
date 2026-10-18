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

  Future<Either<Failure, bool>> verifyResetPassword({
    required String otp,
    required String newPassword,
  });

  Future<Either<Failure, bool>> sendResetOtp({
    required String email,
  });

  Future<Either<Failure, AuthEntity?>> getSavedAuthSession();

  Future<Either<Failure, bool>> signOut();
}
