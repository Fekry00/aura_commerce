import 'package:aura/core/errors/failure.dart';
import 'package:aura/features/checkout/domain/repositories/checkout_repository.dart';
import 'package:aura/features/orders/domain/entities/order_entity.dart';
import 'package:dartz/dartz.dart';

class PlaceOrderUseCase {
  const PlaceOrderUseCase(this.repository);

  final CheckoutRepository repository;

  Future<Either<Failure, OrderEntity>> call({
    required String shippingAddress,
    required String phone,
    String paymentMethod = 'cod',
    String? notes,
    List<Map<String, dynamic>>? items,
  }) {
    return repository.placeOrder(
      shippingAddress: shippingAddress,
      phone: phone,
      paymentMethod: paymentMethod,
      notes: notes,
      items: items,
    );
  }
}
