import 'package:aura/core/errors/failure.dart';
import 'package:aura/features/profile/domain/repositories/profile_repository.dart';
import 'package:dartz/dartz.dart';

class SendPhoneOtpUseCase {
  const SendPhoneOtpUseCase(this.repository);

  final ProfileRepository repository;

  Future<Either<Failure, String>> call({required String phone}) {
    return repository.sendPhoneOtp(phone: phone);
  }
}
