import 'package:aura/core/errors/failure.dart';
import 'package:aura/features/auth/domain/repositories/auth_repository.dart';
import 'package:dartz/dartz.dart';

class AuthChangePasswordUseCase {
  const AuthChangePasswordUseCase(this.repository);

  final AuthRepository repository;

  Future<Either<Failure, bool>> call({
    required String currentPassword,
    required String newPassword,
    required String newPasswordConfirmation,
  }) {
    return repository.changePassword(
      currentPassword: currentPassword,
      newPassword: newPassword,
      newPasswordConfirmation: newPasswordConfirmation,
    );
  }
}
