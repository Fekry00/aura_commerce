import 'package:aura/core/routing/main_tab_controller.dart';
import 'package:aura/core/routing/routes.dart';
import 'package:aura/core/theme/app_colors.dart';
import 'package:aura/core/utils/functions/custom_snack_bar.dart';
import 'package:aura/features/cart/presentation/cubit/cart_cubit.dart';
import 'package:aura/features/cart/presentation/cubit/cart_state.dart';
import 'package:aura/features/cart/presentation/widgets/cart_view_body.dart';
import 'package:aura/features/home/presentation/widgets/home_bottom_nav_bar.dart';
import 'package:aura/features/home/presentation/widgets/home_view_body.dart';
import 'package:aura/features/profile/presentation/widgets/profile_view_body.dart';
import 'package:aura/features/wishlist/presentation/cubit/wishlist_cubit.dart';
import 'package:aura/features/wishlist/presentation/cubit/wishlist_state.dart';
import 'package:aura/features/wishlist/presentation/widgets/wishlist_view_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeView extends StatefulWidget {
  final int? initialIndex;

  const HomeView({super.key, this.initialIndex});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  void initState() {
    super.initState();
    if (widget.initialIndex != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        MainTabController.switchTab(widget.initialIndex!);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<CartCubit, CartState>(
          listener: (context, state) {
            if (state is CartActionSuccessState) {
              showCustomSnackBar(context, message: state.message, type: SnackBarType.success);
            } else if (state is CartNavigateToCheckoutState) {
              Navigator.of(context).pushNamed(Routes.checkoutView);
            } else if (state is CartInfoMessageState) {
              showCustomSnackBar(context, message: state.message, type: SnackBarType.info);
            } else if (state is CartErrorState) {
              showCustomSnackBar(context, message: state.message, type: SnackBarType.error);
            }
          },
        ),
        BlocListener<WishlistCubit, WishlistState>(
          listener: (context, state) {
            if (state is WishlistItemAddedSuccessState) {
              showCustomSnackBar(context, message: state.message, type: SnackBarType.success);
            } else if (state is WishlistItemRemovedSuccessState) {
              showCustomSnackBar(context, message: state.message, type: SnackBarType.info);
            } else if (state is WishlistItemMovedToBagSuccessState) {
              context.read<CartCubit>().fetchCart();
              showCustomSnackBar(context, message: state.message, type: SnackBarType.success);
            } else if (state is WishlistAllMovedToBagSuccessState) {
              context.read<CartCubit>().fetchCart();
              showCustomSnackBar(context, message: state.message, type: SnackBarType.success);
            } else if (state is WishlistInfoMessageState) {
              showCustomSnackBar(context, message: state.message, type: SnackBarType.info);
            } else if (state is WishlistErrorState) {
              showCustomSnackBar(context, message: state.message, type: SnackBarType.error);
            }
          },
        ),
      ],
      child: Scaffold(
        backgroundColor: AppColors.background,
        body: ValueListenableBuilder<int>(
          valueListenable: MainTabController.currentIndex,
          builder: (context, activeIndex, _) {
            return IndexedStack(
              index: activeIndex,
              children: const [
                HomeViewBody(),
                WishlistViewBody(),
                CartViewBody(),
                ProfileViewBody(),
              ],
            );
          },
        ),
        bottomNavigationBar: const HomeBottomNavBar(),
      ),
    );
  }
}