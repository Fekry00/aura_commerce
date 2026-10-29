import 'package:aura/core/routing/routes.dart';
import 'package:aura/core/theme/app_colors.dart';
import 'package:aura/core/theme/app_typography.dart';
import 'package:aura/features/orders/domain/entities/order_entity.dart';
import 'package:aura/features/orders/presentation/widgets/order_success_receipt_body.dart';
import 'package:flutter/material.dart';

class OrderSuccessReceiptView extends StatelessWidget {
  final OrderEntity? order;

  const OrderSuccessReceiptView({
    super.key,
    this.order,
  });

  void _onClose(BuildContext context) {
    Navigator.pushNamedAndRemoveUntil(
      context,
      Routes.homeView,
      (route) => false,
    );
  }

  void _onViewAllOrders(BuildContext context) {
    Navigator.pushNamed(context, Routes.ordersView);
  }

  @override
  Widget build(BuildContext context) {
    final OrderEntity? effectiveOrder = order ??
        (ModalRoute.of(context)?.settings.arguments is OrderEntity
            ? ModalRoute.of(context)!.settings.arguments as OrderEntity
            : null);

    return Scaffold(
      backgroundColor: AppColors.surface,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(
            Icons.close_rounded,
            size: 20,
            color: Color(0xFF002419),
          ),
          onPressed: () => _onClose(context),
        ),
        title: Text(
          'ORDER RECEIPT',
          style: AppTypography.headlineSm.copyWith(
            fontSize: 15,
            fontWeight: FontWeight.w800,
            letterSpacing: 1.5,
            color: const Color(0xFF002419),
          ),
        ),
      ),
      body: effectiveOrder == null
          ? const Center(child: Text('No order details found.'))
          : OrderSuccessReceiptBody(
              order: effectiveOrder,
              onViewAllOrders: () => _onViewAllOrders(context),
              onReturnHome: () => _onClose(context),
            ),
    );
  }
}
