import 'package:aura/core/theme/app_typography.dart';
import 'package:aura/core/widgets/shimmer/cart_shimmer_skeleton.dart';
import 'package:aura/features/cart/presentation/controllers/cart_controller.dart';
import 'package:aura/features/cart/presentation/cubit/cart_cubit.dart';
import 'package:aura/features/cart/presentation/cubit/cart_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'cart_app_bar.dart';
import 'cart_bottom_checkout_tray.dart';
import 'cart_empty_state.dart';
import 'cart_header_section.dart';
import 'cart_items_list_section.dart';
import 'cart_order_summary_card.dart';
import 'cart_shipping_meter_card.dart';
import 'cart_trust_assurances.dart';
import 'cart_voucher_section.dart';

/// Pure declarative layout assembling the Cart screen sections.
class CartViewBody extends StatefulWidget {
  final CartController? controller;

  const CartViewBody({super.key, this.controller});

  @override
  State<CartViewBody> createState() => _CartViewBodyState();
}

class _CartViewBodyState extends State<CartViewBody> {
  late final CartController _controller;
  late final bool _internalController;

  @override
  void initState() {
    super.initState();
    _internalController = widget.controller == null;
    _controller = widget.controller ?? CartController();
  }

  @override
  void dispose() {
    if (_internalController) {
      _controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: BlocBuilder<CartCubit, CartState>(
        builder: (context, state) {
          if (state is CartSuccessState) {
            _controller.updateCart(state.cart);
          }

          final isLoading = state is CartLoadingState && _controller.isEmpty;

          return Stack(
            children: [
              RefreshIndicator(
                color: const Color(0xFF1E382B),
                onRefresh: () async {
                  await context.read<CartCubit>().fetchCart();
                },
                child: SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(
                    parent: BouncingScrollPhysics(),
                  ),
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
                            CartHeaderSection(
                              itemCount: _controller.items.length,
                            ),
                            const SizedBox(
                              height: AppSpacing.spaceSm + AppSpacing.spaceXs,
                            ),
                            if (isLoading) ...[
                              const CartShimmerSkeleton(),
                            ] else if (_controller.isEmpty) ...[
                              const CartEmptyState(),
                            ] else ...[
                              CartShippingMeterCard(controller: _controller),
                              const SizedBox(height: AppSpacing.spaceMd),
                              CartItemsListSection(
                                controller: _controller,
                                onIncrement: (item) =>
                                    _controller.onIncrement(context, item),
                                onDecrement: (item) =>
                                    _controller.onDecrement(context, item),
                                onRemove: (item) =>
                                    _controller.onRemove(context, item),
                              ),
                              const SizedBox(height: AppSpacing.spaceMd),
                              CartVoucherSection(
                                controller: _controller,
                                onApply: () =>
                                    _controller.onApplyVoucher(context),
                                onRemove: () =>
                                    _controller.onRemoveVoucher(context),
                              ),
                              const SizedBox(height: AppSpacing.spaceMd),
                              CartOrderSummaryCard(controller: _controller),
                              const SizedBox(height: AppSpacing.spaceMd),
                              const CartTrustAssurances(),
                            ],
                            const SizedBox(height: AppSpacing.spaceXl * 3),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              if (!_controller.isEmpty)
                Positioned(
                  left: 0,
                  right: 0,
                  bottom: 0,
                  child: CartBottomCheckoutTray(
                    totalPayable: _controller.formattedTotal,
                    onCheckoutPressed: () =>
                        _controller.onProceedToCheckout(context),
                    onExpressCheckoutPressed: () =>
                        _controller.onExpressCheckout(context),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}
