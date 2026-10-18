import 'package:aura/core/errors/failure.dart';
import 'package:aura/features/profile/domain/entities/profile_entity.dart';
import 'package:aura/features/profile/domain/repositories/profile_repository.dart';
import 'package:dartz/dartz.dart';

class GetProfileUseCase {
  const GetProfileUseCase(this.repository);

  final ProfileRepository repository;

  Future<Either<Failure, ProfileEntity>> call() {
    return repository.getProfile();
  }
}
