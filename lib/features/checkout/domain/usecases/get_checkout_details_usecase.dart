import 'package:aura/core/errors/failure.dart';
import 'package:aura/features/checkout/domain/entities/checkout_entity.dart';
import 'package:aura/features/checkout/domain/repositories/checkout_repository.dart';
import 'package:dartz/dartz.dart';

class GetCheckoutDetailsUseCase {
  const GetCheckoutDetailsUseCase(this.repository);

  final CheckoutRepository repository;

  Future<Either<Failure, CheckoutEntity>> call() {
    return repository.getCheckoutDetails();
  }
}
