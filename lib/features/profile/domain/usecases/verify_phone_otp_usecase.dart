import 'package:aura/core/errors/failure.dart';
import 'package:aura/features/profile/domain/entities/profile_entity.dart';
import 'package:aura/features/profile/domain/repositories/profile_repository.dart';
import 'package:dartz/dartz.dart';

class VerifyPhoneOtpUseCase {
  const VerifyPhoneOtpUseCase(this.repository);

  final ProfileRepository repository;

  Future<Either<Failure, ProfileEntity>> call({
    required String phone,
    required String otp,
  }) {
    return repository.verifyPhoneOtp(phone: phone, otp: otp);
  }
}
