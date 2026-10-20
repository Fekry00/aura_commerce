import 'package:aura/core/errors/failure.dart';
import 'package:aura/features/profile/domain/entities/profile_entity.dart';
import 'package:aura/features/profile/domain/repositories/profile_repository.dart';
import 'package:dartz/dartz.dart';

class UpdateProfileUseCase {
  const UpdateProfileUseCase(this.repository);

  final ProfileRepository repository;

  Future<Either<Failure, ProfileEntity>> call({
    required String name,
    required String email,
  }) {
    return repository.updateProfile(name: name, email: email);
  }
}
