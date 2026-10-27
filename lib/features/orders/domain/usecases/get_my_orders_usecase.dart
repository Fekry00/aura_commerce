import 'package:aura/core/errors/failure.dart';
import 'package:aura/features/orders/domain/entities/order_entity.dart';
import 'package:aura/features/orders/domain/repositories/orders_repository.dart';
import 'package:dartz/dartz.dart';

class GetMyOrdersUseCase {
  const GetMyOrdersUseCase(this.repository);

  final OrdersRepository repository;

  Future<Either<Failure, List<OrderEntity>>> call({
    String? status,
    int? perPage,
    int? page,
  }) {
    return repository.getMyOrders(
      status: status,
      perPage: perPage,
      page: page,
    );
  }
}
