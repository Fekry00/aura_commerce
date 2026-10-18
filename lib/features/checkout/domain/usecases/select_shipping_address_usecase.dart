import 'package:aura/core/errors/failure.dart';
import 'package:aura/features/checkout/domain/repositories/checkout_repository.dart';
import 'package:dartz/dartz.dart';

class SelectShippingAddressUseCase {
  const SelectShippingAddressUseCase(this.repository);

  final CheckoutRepository repository;

  Future<Either<Failure, bool>> call({required String addressId}) {
    return repository.selectShippingAddress(addressId: addressId);
  }
}
