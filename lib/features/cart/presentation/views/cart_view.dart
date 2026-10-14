import 'package:aura/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import '../widgets/cart_view_body.dart';

class CartView extends StatelessWidget {
  const CartView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: AppColors.background,
      body: CartViewBody(),
    );
  }
}
