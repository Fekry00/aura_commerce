import 'package:aura/core/routing/routes.dart';
import 'package:aura/features/orders/domain/entities/order_entity.dart';
import 'package:aura/features/orders/presentation/cubit/orders_cubit.dart';
import 'package:aura/features/orders/presentation/widgets/orders_cancel_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OrdersController {
  String selectedFilter = 'all';

  static const List<Map<String, String>> filters = [
    {'key': 'all', 'label': 'All Orders'},
    {'key': 'pending', 'label': 'Pending'},
    {'key': 'shipped', 'label': 'In Transit'},
    {'key': 'delivered', 'label': 'Delivered'},
    {'key': 'cancelled', 'label': 'Cancelled'},
  ];

  List<OrderEntity> getFilteredOrders(List<OrderEntity> allOrders) {
    if (selectedFilter == 'all') {
      return allOrders;
    }
    return allOrders
        .where((o) => o.status.toLowerCase() == selectedFilter)
        .toList();
  }

  String getEmptyMessage() {
    if (selectedFilter == 'all') {
      return 'You have not placed any orders yet. Explore our curated collections to place your first order.';
    }
    return 'No orders found matching the "$selectedFilter" status.';
  }

  void onFilterSelected(String filterKey, VoidCallback onUpdate) {
    if (selectedFilter == filterKey) return;
    selectedFilter = filterKey;
    onUpdate();
  }

  Future<void> onRefresh(BuildContext context) async {
    await context.read<OrdersCubit>().fetchMyOrders();
  }

  void onStartShopping(BuildContext context) {
    Navigator.pushNamedAndRemoveUntil(
      context,
      Routes.homeView,
      (route) => false,
    );
  }

  void onOrderDetailsTap(BuildContext context, OrderEntity order) {
    Navigator.pushNamed(
      context,
      Routes.orderSuccessReceiptView,
      arguments: order,
    );
  }

  void confirmCancelOrder(BuildContext context, OrderEntity order) {
    showDialog(
      context: context,
      builder: (ctx) => OrdersCancelDialog(
        orderId: order.id,
        onKeepOrder: () => Navigator.pop(ctx),
        onConfirmCancel: () {
          Navigator.pop(ctx);
          context.read<OrdersCubit>().cancelOrder(order.id);
        },
      ),
    );
  }
}
