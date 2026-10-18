import 'package:aura/core/errors/failure.dart';
import 'package:aura/features/checkout/domain/repositories/checkout_repository.dart';
import 'package:dartz/dartz.dart';

class ApplyPrivilegePasscodeUseCase {
  const ApplyPrivilegePasscodeUseCase(this.repository);

  final CheckoutRepository repository;

  Future<Either<Failure, bool>> call({required String passcode}) {
    return repository.applyPrivilegePasscode(passcode: passcode);
  }
}
