import 'package:aura/core/errors/failure.dart';
import 'package:aura/features/profile/domain/repositories/profile_repository.dart';
import 'package:dartz/dartz.dart';

class DeleteAccountUseCase {
  const DeleteAccountUseCase(this.repository);

  final ProfileRepository repository;

  Future<Either<Failure, bool>> call({required String password}) {
    return repository.deleteAccount(password: password);
  }
}
