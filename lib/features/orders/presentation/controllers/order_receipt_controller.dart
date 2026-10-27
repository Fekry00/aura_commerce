import 'package:aura/core/routing/routes.dart';
import 'package:flutter/material.dart';

class OrderReceiptController {
  const OrderReceiptController();

  void onCloseReceipt(BuildContext context) {
    Navigator.pushNamedAndRemoveUntil(
      context,
      Routes.homeView,
      (route) => false,
    );
  }

  void onViewAllOrders(BuildContext context) {
    Navigator.pushNamed(context, Routes.ordersView);
  }

  void onReturnHome(BuildContext context) {
    Navigator.pushNamedAndRemoveUntil(
      context,
      Routes.homeView,
      (route) => false,
    );
  }
}
