import 'package:aura/core/errors/failure.dart';
import 'package:aura/features/auth/domain/repositories/auth_repository.dart';
import 'package:dartz/dartz.dart';

class ResetPasswordUseCase {
  const ResetPasswordUseCase(this.repository);

  final AuthRepository repository;

  Future<Either<Failure, bool>> call({
    required String otp,
    required String newPassword,
  }) {
    return repository.resetPassword(otp: otp, newPassword: newPassword);
  }
}
