import 'package:aura/core/routing/routes.dart';
import 'package:aura/core/theme/app_colors.dart';
import 'package:aura/core/utils/functions/custom_snack_bar.dart';
import 'package:aura/features/cart/presentation/cubit/cart_cubit.dart';
import 'package:aura/features/cart/presentation/cubit/cart_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../widgets/cart_view_body.dart';

/// Pure skeleton view for Cart handling reactive navigation and feedback strictly via BlocListener.
class CartView extends StatelessWidget {
  const CartView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: BlocListener<CartCubit, CartState>(
        listener: (context, state) {
          if (state is CartErrorState) {
            showCustomSnackBar(
              context,
              message: state.message,
              type: SnackBarType.error,
            );
          } else if (state is CartActionSuccessState) {
            showCustomSnackBar(
              context,
              message: state.message,
              type: SnackBarType.success,
            );
          } else if (state is CartInfoMessageState) {
            showCustomSnackBar(
              context,
              message: state.message,
              type: SnackBarType.info,
            );
          } else if (state is CartNavigateToCheckoutState) {
            Navigator.of(context).pushNamed(Routes.checkoutView);
          }
        },
        child: const CartViewBody(),
      ),
    );
  }
}
