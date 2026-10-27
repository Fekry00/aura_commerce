import 'package:aura/core/theme/app_colors.dart';
import 'package:aura/features/orders/presentation/controllers/order_tracking_controller.dart';
import 'package:aura/features/orders/presentation/widgets/order_receipt_app_bar.dart';
import 'package:aura/features/orders/presentation/widgets/order_tracking_details_body.dart';
import 'package:flutter/material.dart';

class OrderTrackingDetailsView extends StatelessWidget {
  final OrderTrackingController controller;

  const OrderTrackingDetailsView({
    super.key,
    this.controller = const OrderTrackingController(),
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surface,
      appBar: const OrderReceiptAppBar(title: 'Dispatch Logistics'),
      body: OrderTrackingDetailsBody(controller: controller),
    );
  }
}
