import 'package:aura/core/theme/app_colors.dart';
import 'package:aura/core/theme/app_typography.dart';
import 'package:aura/core/utils/functions/custom_snack_bar.dart';
import 'package:aura/features/orders/presentation/controllers/orders_controller.dart';
import 'package:aura/features/orders/presentation/cubit/orders_cubit.dart';
import 'package:aura/features/orders/presentation/cubit/orders_state.dart';
import 'package:aura/features/orders/presentation/widgets/orders_view_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OrdersView extends StatefulWidget {
  const OrdersView({super.key});

  @override
  State<OrdersView> createState() => _OrdersViewState();
}

class _OrdersViewState extends State<OrdersView> {
  final OrdersController _controller = OrdersController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<OrdersCubit>().fetchMyOrders();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            size: 18,
            color: Color(0xFF002419),
          ),
          onPressed: () => Navigator.maybePop(context),
        ),
        title: Text(
          'MY ORDERS',
          style: AppTypography.headlineSm.copyWith(
            fontSize: 16,
            fontWeight: FontWeight.w800,
            letterSpacing: 1.5,
            color: const Color(0xFF002419),
          ),
        ),
      ),
      body: BlocConsumer<OrdersCubit, OrdersState>(
        listener: (context, state) {
          if (state is OrdersErrorState) {
            showCustomSnackBar(
              context,
              message: state.message,
              type: SnackBarType.error,
            );
          } else if (state is OrderCancelSuccessState) {
            showCustomSnackBar(
              context,
              message: 'Order #AUR-${state.order.id} cancelled successfully.',
              type: SnackBarType.info,
            );
            context.read<OrdersCubit>().fetchMyOrders();
          }
        },
        builder: (context, state) {
          final orders = context.read<OrdersCubit>().orders;
          final isLoading = state is OrdersLoadingState;

          return OrdersViewBody(
            orders: orders,
            isLoading: isLoading,
            controller: _controller,
            onStateUpdate: () => setState(() {}),
          );
        },
      ),
    );
  }
}
