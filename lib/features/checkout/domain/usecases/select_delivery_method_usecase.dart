import 'package:aura/core/errors/failure.dart';
import 'package:aura/features/checkout/domain/repositories/checkout_repository.dart';
import 'package:dartz/dartz.dart';

class SelectDeliveryMethodUseCase {
  const SelectDeliveryMethodUseCase(this.repository);

  final CheckoutRepository repository;

  Future<Either<Failure, bool>> call({required String methodId}) {
    return repository.selectDeliveryMethod(methodId: methodId);
  }
}
