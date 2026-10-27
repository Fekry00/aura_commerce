import 'package:aura/core/theme/app_colors.dart';
import 'package:aura/core/theme/app_typography.dart';
import 'package:aura/features/orders/domain/entities/order_entity.dart';
import 'package:aura/features/orders/presentation/controllers/order_receipt_controller.dart';
import 'package:aura/features/orders/presentation/widgets/order_success_receipt_body.dart';
import 'package:flutter/material.dart';

class OrderSuccessReceiptView extends StatelessWidget {
  final OrderEntity? order;
  final OrderReceiptController controller;

  const OrderSuccessReceiptView({
    super.key,
    this.order,
    this.controller = const OrderReceiptController(),
  });

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
          onPressed: () => controller.onCloseReceipt(context),
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
              controller: controller,
            ),
    );
  }
}
