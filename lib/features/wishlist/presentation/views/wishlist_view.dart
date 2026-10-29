import 'package:aura/core/routing/main_tab_controller.dart';
import 'package:aura/core/theme/app_colors.dart';
import 'package:aura/core/utils/functions/custom_snack_bar.dart';
import 'package:aura/features/cart/presentation/cubit/cart_cubit.dart';
import 'package:aura/features/wishlist/presentation/cubit/wishlist_cubit.dart';
import 'package:aura/features/wishlist/presentation/cubit/wishlist_state.dart';
import 'package:aura/features/wishlist/presentation/widgets/wishlist_view_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WishlistView extends StatefulWidget {
  const WishlistView({super.key});

  @override
  State<WishlistView> createState() => _WishlistViewState();
}

class _WishlistViewState extends State<WishlistView> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (context.read<WishlistCubit>().state is WishlistInitialState) {
        context.read<WishlistCubit>().fetchWishlist();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surface,
      body: BlocListener<WishlistCubit, WishlistState>(
        listener: (context, state) {
          if (state is WishlistItemAddedSuccessState) {
            showCustomSnackBar(context, message: state.message, type: SnackBarType.success);
          } else if (state is WishlistItemRemovedSuccessState) {
            showCustomSnackBar(context, message: state.message, type: SnackBarType.info);
          } else if (state is WishlistItemMovedToBagSuccessState) {
            context.read<CartCubit>().fetchCart();
            showCustomSnackBar(context, message: state.message, type: SnackBarType.success);
            MainTabController.switchTab(2);
          } else if (state is WishlistAllMovedToBagSuccessState) {
            context.read<CartCubit>().fetchCart();
            showCustomSnackBar(context, message: state.message, type: SnackBarType.success);
            MainTabController.switchTab(2);
          } else if (state is WishlistInfoMessageState) {
            showCustomSnackBar(context, message: state.message, type: SnackBarType.info);
          } else if (state is WishlistErrorState) {
            showCustomSnackBar(context, message: state.message, type: SnackBarType.error);
          }
        },
        child: const WishlistViewBody(),
      ),
    );
  }
}
