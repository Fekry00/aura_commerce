import 'package:aura/core/widgets/shimmer/orders_shimmer_skeleton.dart';
import 'package:aura/features/orders/domain/entities/order_entity.dart';
import 'package:aura/features/orders/presentation/controllers/orders_controller.dart';
import 'package:flutter/material.dart';
import 'order_card.dart';
import 'orders_empty_state.dart';
import 'orders_filter_tabs.dart';

class OrdersViewBody extends StatelessWidget {
  final List<OrderEntity> orders;
  final bool isLoading;
  final OrdersController controller;
  final VoidCallback onStateUpdate;

  const OrdersViewBody({
    super.key,
    required this.orders,
    required this.isLoading,
    required this.controller,
    required this.onStateUpdate,
  });

  @override
  Widget build(BuildContext context) {
    final filteredOrders = controller.getFilteredOrders(orders);

    return RefreshIndicator(
      color: const Color(0xFF0B3B2C),
      onRefresh: () => controller.onRefresh(context),
      child: Column(
        children: [
          // Filter Tabs
          OrdersFilterTabs(
            selectedFilter: controller.selectedFilter,
            onFilterSelected: (key) =>
                controller.onFilterSelected(key, onStateUpdate),
          ),

          // Orders List
          Expanded(
            child: isLoading && orders.isEmpty
                ? const OrdersShimmerSkeleton()
                : filteredOrders.isEmpty
                    ? OrdersEmptyState(
                        message: controller.getEmptyMessage(),
                        onStartShopping: () =>
                            controller.onStartShopping(context),
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
                            onDetailsTap: (o) =>
                                controller.onOrderDetailsTap(context, o),
                            onCancelTap: (o) =>
                                controller.confirmCancelOrder(context, o),
                          );
                        },
                      ),
          ),
        ],
      ),
    );
  }
}
