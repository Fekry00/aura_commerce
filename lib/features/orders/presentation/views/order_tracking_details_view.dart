import 'package:aura/core/theme/app_colors.dart';
import 'package:aura/core/theme/app_typography.dart';
import 'package:aura/features/orders/domain/entities/order_entity.dart';
import 'package:aura/features/orders/presentation/cubit/orders_cubit.dart';
import 'package:aura/features/orders/presentation/cubit/orders_state.dart';
import 'package:aura/features/orders/presentation/widgets/order_details_shimmer.dart';
import 'package:aura/features/orders/presentation/widgets/order_receipt_app_bar.dart';
import 'package:aura/features/orders/presentation/widgets/order_tracking_details_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OrderTrackingDetailsView extends StatelessWidget {
  final int? orderId;
  final OrderEntity? initialOrder;

  const OrderTrackingDetailsView({
    super.key,
    this.orderId,
    this.initialOrder,
  });

  int _resolveOrderId(BuildContext context) {
    if (orderId != null) return orderId!;
    if (initialOrder != null) return initialOrder!.id;
    final args = ModalRoute.of(context)?.settings.arguments;
    if (args is int) return args;
    if (args is OrderEntity) return args.id;
    return 1;
  }

  @override
  Widget build(BuildContext context) {
    final resolvedId = _resolveOrderId(context);
    return Scaffold(
      backgroundColor: AppColors.surface,
      appBar: const OrderReceiptAppBar(title: 'Dispatch Logistics'),
      body: BlocBuilder<OrdersCubit, OrdersState>(
        builder: (context, state) {
          if (state is OrdersLoadingState && initialOrder == null) {
            return const OrderDetailsShimmer();
          }

          if (state is OrdersErrorState && initialOrder == null) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppSpacing.gutter),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.error_outline_rounded,
                      size: 48,
                      color: AppColors.error,
                    ),
                    const SizedBox(height: AppSpacing.spaceSm),
                    Text(
                      state.message,
                      textAlign: TextAlign.center,
                      style: AppTypography.bodyMd.copyWith(color: AppColors.slateHeadline),
                    ),
                    const SizedBox(height: AppSpacing.spaceMd),
                    ElevatedButton(
                      onPressed: () => context.read<OrdersCubit>().fetchOrderTracking(resolvedId),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.secondary,
                        foregroundColor: Colors.white,
                      ),
                      child: const Text('Retry Tracking'),
                    ),
                  ],
                ),
              ),
            );
          }

          final order = (state is OrderTrackingSuccessState)
              ? state.order
              : (state is OrderDetailsSuccessState)
                  ? state.order
                  : initialOrder;

          if (order == null) {
            return const Center(child: Text('No tracking data found.'));
          }

          return RefreshIndicator(
            color: AppColors.secondary,
            onRefresh: () => context.read<OrdersCubit>().fetchOrderTracking(resolvedId),
            child: OrderTrackingDetailsBody(order: order),
          );
        },
      ),
    );
  }
}
