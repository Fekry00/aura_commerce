import 'package:aura/core/theme/app_colors.dart';
import 'package:aura/core/theme/app_typography.dart';
import 'package:aura/core/widgets/custom_bottom_nav_bar.dart';
import 'package:aura/features/cart/presentation/widgets/cart_app_bar.dart';
import 'package:aura/features/cart/presentation/widgets/cart_bottom_checkout_tray.dart';
import 'package:aura/features/cart/presentation/widgets/cart_controller.dart';
import 'package:aura/features/cart/presentation/widgets/cart_header_section.dart';
import 'package:aura/features/cart/presentation/widgets/cart_items_list_section.dart';
import 'package:aura/features/cart/presentation/widgets/cart_order_summary_card.dart';
import 'package:aura/features/cart/presentation/widgets/cart_shipping_meter_card.dart';
import 'package:aura/features/cart/presentation/widgets/cart_trust_assurances.dart';
import 'package:aura/features/cart/presentation/widgets/cart_voucher_section.dart';
import 'package:flutter/material.dart';

class CartView extends StatefulWidget {
  const CartView({super.key});

  @override
  State<CartView> createState() => _CartViewState();
}

class _CartViewState extends State<CartView> {
  int _currentNavIndex = 2;
  late final CartController _controller;

  @override
  void initState() {
    super.initState();
    _controller = CartController()..addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (!_controller.isEmpty)
            CartBottomCheckoutTray(totalPayable: _controller.formattedTotal),
          CustomBottomNavBar(
            selectedIndex: _currentNavIndex,
            onItemTapped: (index) => setState(() => _currentNavIndex = index),
          ),
        ],
      ),
      body: SafeArea(
        bottom: false,
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: AppSpacing.spaceSm),
              const CartAppBar(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppSpacing.margin),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CartHeaderSection(itemCount: _controller.items.length),
                    const SizedBox(height: AppSpacing.spaceSm + AppSpacing.spaceXs),
                    CartShippingMeterCard(controller: _controller),
                    const SizedBox(height: AppSpacing.spaceMd),
                    CartItemsListSection(controller: _controller),
                    const SizedBox(height: AppSpacing.spaceMd),
                    CartVoucherSection(controller: _controller),
                    const SizedBox(height: AppSpacing.spaceMd),
                    CartOrderSummaryCard(controller: _controller),
                    const SizedBox(height: AppSpacing.spaceMd),
                    const CartTrustAssurances(),
                    const SizedBox(height: AppSpacing.spaceLg),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
