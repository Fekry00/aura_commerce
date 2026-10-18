import 'package:aura/core/errors/failure.dart';
import 'package:aura/features/orders/domain/entities/order_entity.dart';
import 'package:aura/features/orders/domain/entities/sub_entities/order_tracking_entity.dart';
import 'package:dartz/dartz.dart';

abstract class OrdersRepository {
  Future<Either<Failure, OrderEntity>> getOrderDetails({String? orderId});

  Future<Either<Failure, OrderTrackingEntity>> getOrderTracking({
    String? orderId,
  });

  Future<Either<Failure, bool>> downloadInvoice({required String orderId});
}
