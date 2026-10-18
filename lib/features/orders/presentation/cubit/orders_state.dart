import 'package:aura/features/orders/domain/entities/order_entity.dart';
import 'package:aura/features/orders/domain/entities/sub_entities/order_tracking_entity.dart';

abstract class OrdersState {
  const OrdersState();
}

class OrdersInitialState extends OrdersState {
  const OrdersInitialState();
}

class OrdersLoadingState extends OrdersState {
  const OrdersLoadingState();
}

class OrdersSuccessState extends OrdersState {
  const OrdersSuccessState({required this.order});

  final OrderEntity order;
}

class OrderTrackingSuccessState extends OrdersState {
  const OrderTrackingSuccessState({required this.tracking});

  final OrderTrackingEntity tracking;
}

class OrdersErrorState extends OrdersState {
  const OrdersErrorState({required this.message});

  final String message;
}
