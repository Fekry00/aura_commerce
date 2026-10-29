import 'package:aura/core/routing/routes.dart';
import 'package:aura/features/orders/domain/entities/order_entity.dart';
import 'package:aura/features/orders/presentation/cubit/orders_cubit.dart';
import 'package:aura/features/orders/presentation/widgets/order_card.dart';
import 'package:aura/features/orders/presentation/widgets/orders_cancel_dialog.dart';
import 'package:aura/features/orders/presentation/widgets/orders_empty_state.dart';
import 'package:aura/features/orders/presentation/widgets/orders_filter_tabs.dart';
import 'package:aura/features/orders/presentation/widgets/orders_shimmer_skeleton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OrdersViewBody extends StatelessWidget {
  const OrdersViewBody({
    super.key,
    required this.orders,
    required this.filteredOrders,
    required this.selectedFilter,
    required this.emptyMessage,
    required this.isLoading,
  });

  final List<OrderEntity> orders;
  final List<OrderEntity> filteredOrders;
  final String selectedFilter;
  final String emptyMessage;
  final bool isLoading;

  void _onStartShopping(BuildContext context) {
    Navigator.pushNamedAndRemoveUntil(
      context,
      Routes.homeView,
      (route) => false,
    );
  }

  void _onOrderDetailsTap(BuildContext context, OrderEntity order) {
    Navigator.pushNamed(
      context,
      Routes.orderSuccessReceiptView,
      arguments: order,
    );
  }

  void _confirmCancelOrder(BuildContext context, OrderEntity order) {
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

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<OrdersCubit>();

    return RefreshIndicator(
      color: const Color(0xFF0B3B2C),
      onRefresh: () => cubit.fetchMyOrders(),
      child: Column(
        children: [
          OrdersFilterTabs(
            selectedFilter: selectedFilter,
            onFilterSelected: (key) => cubit.setFilter(key),
          ),
          Expanded(
            child: isLoading
                ? const OrdersShimmerSkeleton()
                : filteredOrders.isEmpty
                    ? OrdersEmptyState(
                        message: emptyMessage,
                        onStartShopping: () => _onStartShopping(context),
                      )
                    : ListView.separated(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 14,
                        ),
                        physics: const AlwaysScrollableScrollPhysics(
                          parent: BouncingScrollPhysics(),
                        ),
                        itemCount: filteredOrders.length,
                        separatorBuilder: (context, index) =>
                            const SizedBox(height: 12),
                        itemBuilder: (context, index) {
                          final order = filteredOrders[index];
                          return OrderCard(
                            order: order,
                            onDetailsTap: (o) => _onOrderDetailsTap(context, o),
                            onCancelTap: (o) => _confirmCancelOrder(context, o),
                          );
                        },
                      ),
          ),
        ],
      ),
    );
  }
}
