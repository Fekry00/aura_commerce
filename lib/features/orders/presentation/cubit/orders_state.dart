import 'package:aura/features/orders/domain/entities/order_entity.dart';

abstract class OrdersState {
  const OrdersState();
}

class OrdersInitialState extends OrdersState {
  const OrdersInitialState();
}

class OrdersLoadingState extends OrdersState {
  const OrdersLoadingState();
}

class OrdersListSuccessState extends OrdersState {
  const OrdersListSuccessState({required this.orders});

  final List<OrderEntity> orders;
}

class OrderDetailsSuccessState extends OrdersState {
  const OrderDetailsSuccessState({required this.order});

  final OrderEntity order;
}

class OrderCancelSuccessState extends OrdersState {
  const OrderCancelSuccessState({required this.order});

  final OrderEntity order;
}

class OrdersSuccessState extends OrdersState {
  const OrdersSuccessState({required this.order});

  final OrderEntity order;
}

class OrdersErrorState extends OrdersState {
  const OrdersErrorState({required this.message});

  final String message;
}
