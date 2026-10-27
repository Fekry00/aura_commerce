import 'package:aura/core/routing/main_tab_controller.dart';
import 'package:aura/core/widgets/custom_bottom_nav_bar.dart';
import 'package:aura/features/cart/presentation/cubit/cart_cubit.dart';
import 'package:aura/features/cart/presentation/cubit/cart_state.dart';
import 'package:aura/features/wishlist/presentation/cubit/wishlist_cubit.dart';
import 'package:aura/features/wishlist/presentation/cubit/wishlist_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeBottomNavBar extends StatefulWidget {
  const HomeBottomNavBar({super.key});

  @override
  State<HomeBottomNavBar> createState() => _HomeBottomNavBarState();
}

class _HomeBottomNavBarState extends State<HomeBottomNavBar> {
  int _lastCartCount = 0;
  int _lastWishlistCount = 0;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<int>(
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
    );
  }
}
