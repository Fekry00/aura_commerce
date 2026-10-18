import 'package:aura/core/errors/failure.dart';
import 'package:aura/features/auth/domain/entities/auth_entity.dart';
import 'package:aura/features/auth/domain/repositories/auth_repository.dart';
import 'package:dartz/dartz.dart';

class SignInUseCase {
  const SignInUseCase(this.repository);

  final AuthRepository repository;

  Future<Either<Failure, AuthEntity>> call({
    required String email,
    required String password,
    bool rememberDevice = true,
  }) {
    return repository.signIn(
      email: email,
      password: password,
      rememberDevice: rememberDevice,
    );
  }
}
