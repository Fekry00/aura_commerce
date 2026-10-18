import 'package:aura/core/errors/failure.dart';
import 'package:aura/features/checkout/domain/repositories/checkout_repository.dart';
import 'package:dartz/dartz.dart';

class PlaceOrderUseCase {
  const PlaceOrderUseCase(this.repository);

  final CheckoutRepository repository;

  Future<Either<Failure, String>> call({
    required String addressId,
    required String deliveryMethodId,
    String? deliveryNotes,
    String? passcode,
  }) {
    return repository.placeOrder(
      addressId: addressId,
      deliveryMethodId: deliveryMethodId,
      deliveryNotes: deliveryNotes,
      passcode: passcode,
    );
  }
}
