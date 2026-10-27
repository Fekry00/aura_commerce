import 'package:aura/core/routing/main_tab_controller.dart';
import 'package:aura/core/theme/app_colors.dart';
import 'package:aura/features/cart/presentation/widgets/cart_view_body.dart';
import 'package:aura/features/home/presentation/widgets/home_bottom_nav_bar.dart';
import 'package:aura/features/home/presentation/widgets/home_view_body.dart';
import 'package:aura/features/profile/presentation/widgets/profile_view_body.dart';
import 'package:aura/features/wishlist/presentation/widgets/wishlist_view_body.dart';
import 'package:flutter/material.dart';

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
      bottomNavigationBar: const HomeBottomNavBar(),
    );
  }
}