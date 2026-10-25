import 'package:aura/core/errors/failure.dart';
import 'package:aura/features/auth/domain/repositories/auth_repository.dart';
import 'package:dartz/dartz.dart';

class LogoutUseCase {
  const LogoutUseCase(this.repository);

  final AuthRepository repository;

  Future<Either<Failure, bool>> call() {
    return repository.logout();
  }
}
