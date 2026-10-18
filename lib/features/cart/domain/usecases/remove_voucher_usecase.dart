import 'package:aura/core/errors/failure.dart';
import 'package:aura/features/cart/domain/repositories/cart_repository.dart';
import 'package:dartz/dartz.dart';

class RemoveVoucherUseCase {
  const RemoveVoucherUseCase(this.repository);

  final CartRepository repository;

  Future<Either<Failure, bool>> call() {
    return repository.removeVoucher();
  }
}
