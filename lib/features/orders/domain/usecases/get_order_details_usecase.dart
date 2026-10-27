import 'package:aura/core/errors/failure.dart';
import 'package:aura/features/orders/domain/entities/order_entity.dart';
import 'package:aura/features/orders/domain/repositories/orders_repository.dart';
import 'package:dartz/dartz.dart';

class GetOrderDetailsUseCase {
  const GetOrderDetailsUseCase(this.repository);

  final OrdersRepository repository;

  Future<Either<Failure, OrderEntity>> call(int orderId) {
    return repository.getOrderDetails(orderId);
  }
}
