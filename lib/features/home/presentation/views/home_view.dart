import 'package:aura/core/routing/main_tab_controller.dart';
import 'package:aura/core/theme/app_colors.dart';
import 'package:aura/core/widgets/custom_bottom_nav_bar.dart';
import 'package:aura/features/cart/presentation/cubit/cart_cubit.dart';
import 'package:aura/features/cart/presentation/cubit/cart_state.dart';
import 'package:aura/features/cart/presentation/widgets/cart_view_body.dart';
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
  int _lastCartCount = 0;
  int _lastWishlistCount = 0;

  @override
  void initState() {
    super.initState();
    if (widget.initialIndex != null) {
      MainTabController.switchTab(widget.initialIndex!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      bottomNavigationBar: ValueListenableBuilder<int>(
        valueListenable: MainTabController.currentIndex,
        builder: (context, activeIndex, _) {
          return BlocBuilder<CartCubit, CartState>(
            builder: (context, cartState) {
              if (cartState is CartSuccessState) {
                _lastCartCount = cartState.cart.items.fold<int>(
                  0,
                  (sum, item) => sum + item.quantity,
                );
              }

              return BlocBuilder<WishlistCubit, WishlistState>(
                builder: (context, wishlistState) {
                  if (wishlistState is WishlistSuccessState) {
                    _lastWishlistCount = wishlistState.wishlist.items.length;
                  }

                  return CustomBottomNavBar(
                    selectedIndex: activeIndex,
                    cartBadgeCount: _lastCartCount,
                    wishlistBadgeCount: _lastWishlistCount,
                    onItemTapped: (index) => MainTabController.switchTab(index),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}