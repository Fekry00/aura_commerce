import 'package:aura/core/errors/failure.dart';
import 'package:aura/features/auth/domain/repositories/auth_repository.dart';
import 'package:dartz/dartz.dart';

class VerifyResetPasswordUseCase {
  const VerifyResetPasswordUseCase(this.repository);

  final AuthRepository repository;

  Future<Either<Failure, bool>> call({
    required String otp,
    required String newPassword,
  }) {
    return repository.verifyResetPassword(
      otp: otp,
      newPassword: newPassword,
    );
  }
}
