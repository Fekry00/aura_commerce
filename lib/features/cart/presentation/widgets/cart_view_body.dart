import 'package:aura/core/theme/app_typography.dart';
import 'package:flutter/material.dart';
import 'cart_app_bar.dart';
import 'cart_bottom_checkout_tray.dart';
import 'cart_controller.dart';
import 'cart_header_section.dart';
import 'cart_items_list_section.dart';
import 'cart_order_summary_card.dart';
import 'cart_shipping_meter_card.dart';
import 'cart_trust_assurances.dart';
import 'cart_voucher_section.dart';

class CartViewBody extends StatefulWidget {
  const CartViewBody({super.key});

  @override
  State<CartViewBody> createState() => _CartViewBodyState();
}

class _CartViewBodyState extends State<CartViewBody> {
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
    return SafeArea(
      bottom: false,
      child: Stack(
        children: [
          SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: AppSpacing.spaceSm),
                const CartAppBar(),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.margin,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CartHeaderSection(itemCount: _controller.items.length),
                      const SizedBox(
                        height: AppSpacing.spaceSm + AppSpacing.spaceXs,
                      ),
                      CartShippingMeterCard(controller: _controller),
                      const SizedBox(height: AppSpacing.spaceMd),
                      CartItemsListSection(controller: _controller),
                      const SizedBox(height: AppSpacing.spaceMd),
                      CartVoucherSection(controller: _controller),
                      const SizedBox(height: AppSpacing.spaceMd),
                      CartOrderSummaryCard(controller: _controller),
                      const SizedBox(height: AppSpacing.spaceMd),
                      const CartTrustAssurances(),
                      const SizedBox(height: AppSpacing.spaceXl * 3),
                    ],
                  ),
                ),
              ],
            ),
          ),
          if (!_controller.isEmpty)
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: CartBottomCheckoutTray(
                totalPayable: _controller.formattedTotal,
              ),
            ),
        ],
      ),
    );
  }
}
