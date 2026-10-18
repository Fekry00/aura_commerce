import 'package:aura/core/errors/failure.dart';
import 'package:aura/features/auth/domain/entities/auth_entity.dart';
import 'package:aura/features/auth/domain/repositories/auth_repository.dart';
import 'package:dartz/dartz.dart';

class SignUpUseCase {
  const SignUpUseCase(this.repository);

  final AuthRepository repository;

  Future<Either<Failure, AuthEntity>> call({
    required String name,
    required String email,
    required String phone,
    required String password,
  }) {
    return repository.signUp(
      name: name,
      email: email,
      phone: phone,
      password: password,
    );
  }
}
