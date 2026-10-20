import 'package:aura/core/errors/failure.dart';
import 'package:aura/features/profile/domain/entities/profile_entity.dart';
import 'package:dartz/dartz.dart';

abstract class ProfileRepository {
  Future<Either<Failure, ProfileEntity>> getProfile();

  Future<Either<Failure, ProfileEntity>> updateProfile({
    required String name,
    required String email,
  });

  Future<Either<Failure, ProfileEntity>> updateAvatar({
    required String imagePath,
  });

  Future<Either<Failure, ProfileEntity>> deleteAvatar();

  Future<Either<Failure, String>> sendPhoneOtp({
    required String phone,
  });

  Future<Either<Failure, ProfileEntity>> verifyPhoneOtp({
    required String phone,
    required String otp,
  });

  Future<Either<Failure, bool>> changePassword({
    required String currentPassword,
    required String newPassword,
    required String newPasswordConfirmation,
  });

  Future<Either<Failure, bool>> deleteAccount({
    required String password,
  });

  Future<Either<Failure, bool>> signOut();
}
