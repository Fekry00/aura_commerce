import 'package:aura/core/errors/failure.dart';
import 'package:aura/features/orders/domain/entities/order_entity.dart';
import 'package:dartz/dartz.dart';

abstract class OrdersRepository {
  Future<Either<Failure, List<OrderEntity>>> getMyOrders({
    String? status,
    int? perPage,
    int? page,
  });

  Future<Either<Failure, OrderEntity>> getOrderDetails(int orderId);

  Future<Either<Failure, OrderEntity>> cancelOrder(int orderId);

  Future<Either<Failure, bool>> downloadInvoice({required String orderId});
}
