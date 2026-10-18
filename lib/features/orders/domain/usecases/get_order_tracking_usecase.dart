import 'package:aura/core/errors/failure.dart';
import 'package:aura/features/orders/domain/entities/sub_entities/order_tracking_entity.dart';
import 'package:aura/features/orders/domain/repositories/orders_repository.dart';
import 'package:dartz/dartz.dart';

class GetOrderTrackingUseCase {
  const GetOrderTrackingUseCase(this.repository);

  final OrdersRepository repository;

  Future<Either<Failure, OrderTrackingEntity>> call({String? orderId}) {
    return repository.getOrderTracking(orderId: orderId);
  }
}
