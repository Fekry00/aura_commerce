import 'package:aura/core/theme/app_colors.dart';
import 'package:aura/core/utils/functions/custom_snack_bar.dart';
import 'package:aura/features/cart/presentation/controllers/cart_controller.dart';
import 'package:aura/features/cart/presentation/cubit/cart_cubit.dart';
import 'package:aura/features/cart/presentation/cubit/cart_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../widgets/cart_view_body.dart';

/// Pure skeleton view for Cart assembling the main body structure.
class CartView extends StatelessWidget {
  final CartController? controller;

  const CartView({super.key, this.controller});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: BlocListener<CartCubit, CartState>(
        listenWhen: (previous, current) => current is CartErrorState,
        listener: (context, state) {
          if (state is CartErrorState) {
            showCustomSnackBar(
              context,
              message: state.message,
              type: SnackBarType.error,
            );
          }
        },
        child: CartViewBody(controller: controller),
      ),
    );
  }
}
