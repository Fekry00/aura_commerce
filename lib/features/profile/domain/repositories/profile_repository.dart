import 'package:aura/core/errors/failure.dart';
import 'package:aura/features/profile/domain/entities/profile_entity.dart';
import 'package:dartz/dartz.dart';

abstract class ProfileRepository {
  Future<Either<Failure, ProfileEntity>> getProfile();

  Future<Either<Failure, bool>> updateProfile({
    required String name,
    required String phone,
  });

  Future<Either<Failure, bool>> signOut();
}
