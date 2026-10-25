import 'package:aura/core/errors/failure.dart';
import 'package:aura/features/auth/domain/entities/auth_entity.dart';
import 'package:aura/features/auth/domain/repositories/auth_repository.dart';
import 'package:dartz/dartz.dart';

class RefreshTokenUseCase {
  const RefreshTokenUseCase(this.repository);

  final AuthRepository repository;

  Future<Either<Failure, AuthEntity>> call() {
    return repository.refreshToken();
  }
}
