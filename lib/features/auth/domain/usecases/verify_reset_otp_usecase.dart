import 'package:aura/core/errors/failure.dart';
import 'package:aura/features/auth/domain/repositories/auth_repository.dart';
import 'package:dartz/dartz.dart';

class VerifyResetOtpUseCase {
  const VerifyResetOtpUseCase(this.repository);

  final AuthRepository repository;

  Future<Either<Failure, bool>> call({
    required String otp,
    String? email,
  }) {
    return repository.verifyResetOtp(otp: otp, email: email);
  }
}
