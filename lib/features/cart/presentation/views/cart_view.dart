import 'package:aura/core/theme/app_colors.dart';
import 'package:aura/features/cart/presentation/controllers/cart_controller.dart';
import 'package:flutter/material.dart';
import '../widgets/cart_view_body.dart';

/// Pure skeleton view for Cart assembling the main body structure.
class CartView extends StatelessWidget {
  final CartController? controller;

  const CartView({super.key, this.controller});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: CartViewBody(controller: controller),
    );
  }
}
