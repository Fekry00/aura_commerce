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
  const OrdersListSuccessState({
    required this.orders,
    this.selectedFilter = 'all',
  });

  final List<OrderEntity> orders;
  final String selectedFilter;

  static const List<Map<String, String>> filters = [
    {'key': 'all', 'label': 'All Orders'},
    {'key': 'pending', 'label': 'Pending'},
    {'key': 'shipped', 'label': 'In Transit'},
    {'key': 'delivered', 'label': 'Delivered'},
    {'key': 'cancelled', 'label': 'Cancelled'},
  ];

  List<OrderEntity> get filteredOrders {
    if (selectedFilter == 'all') {
      return orders;
    }
    return orders
        .where((o) => o.status.toLowerCase() == selectedFilter)
        .toList();
  }

  String get emptyMessage {
    if (selectedFilter == 'all') {
      return 'You have not placed any orders yet. Explore our curated collections to place your first order.';
    }
    return 'No orders found matching the "$selectedFilter" status.';
  }

  OrdersListSuccessState copyWith({
    List<OrderEntity>? orders,
    String? selectedFilter,
  }) {
    return OrdersListSuccessState(
      orders: orders ?? this.orders,
      selectedFilter: selectedFilter ?? this.selectedFilter,
    );
  }
}

class OrderDetailsSuccessState extends OrdersState {
  const OrderDetailsSuccessState({required this.order});

  final OrderEntity order;
}

class OrderTrackingSuccessState extends OrdersState {
  const OrderTrackingSuccessState({required this.order});

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
