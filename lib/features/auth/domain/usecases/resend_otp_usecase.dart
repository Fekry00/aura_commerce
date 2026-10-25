import 'package:aura/core/errors/failure.dart';
import 'package:aura/features/auth/domain/repositories/auth_repository.dart';
import 'package:dartz/dartz.dart';

class ResendOtpUseCase {
  const ResendOtpUseCase(this.repository);

  final AuthRepository repository;

  Future<Either<Failure, bool>> call({required String email}) {
    return repository.resendOtp(email: email);
  }
}
