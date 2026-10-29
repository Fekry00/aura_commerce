import 'package:aura/core/theme/app_typography.dart';
import 'package:aura/core/widgets/shimmer/cart_shimmer_skeleton.dart';
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

/// Pure declarative layout assembling the Cart screen sections with 100% Cubit reactivity.
class CartViewBody extends StatelessWidget {
  const CartViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: BlocBuilder<CartCubit, CartState>(
        builder: (context, state) {
          final cubit = context.read<CartCubit>();
          final cart = state is CartSuccessState
              ? state.cart
              : cubit.currentCart;

          final isLoading = state is CartLoadingState && cart == null;
          final isEmpty = cart == null || cart.isEmpty;

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
                              itemCount: cart?.items.length ?? 0,
                            ),
                            const SizedBox(
                              height: AppSpacing.spaceSm + AppSpacing.spaceXs,
                            ),
                            if (isLoading) ...[
                              const CartShimmerSkeleton(),
                            ] else if (isEmpty) ...[
                              const CartEmptyState(),
                            ] else ...[
                              CartShippingMeterCard(meter: cart.shippingMeter),
                              const SizedBox(height: AppSpacing.spaceMd),
                              CartItemsListSection(
                                items: cart.items,
                                onIncrement: (item) => cubit.incrementQuantity(
                                  item.id,
                                  item.quantity,
                                ),
                                onDecrement: (item) => cubit.decrementQuantity(
                                  item.id,
                                  item.quantity,
                                ),
                                onRemove: (item) => cubit.removeCartItem(item.id),
                              ),
                              const SizedBox(height: AppSpacing.spaceMd),
                              CartVoucherSection(
                                activeVoucherCode: cart.activeVoucherCode,
                                voucherLabel: cart.voucherLabel,
                                hasActiveVoucher: cart.hasDiscount,
                                onApply: (code) => cubit.applyVoucher(code),
                                onRemove: () => cubit.removeVoucher(),
                              ),
                              const SizedBox(height: AppSpacing.spaceMd),
                              CartOrderSummaryCard(cart: cart),
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
              if (!isEmpty)
                Positioned(
                  left: 0,
                  right: 0,
                  bottom: 0,
                  child: CartBottomCheckoutTray(
                    totalPayable: cart.formattedTotal,
                    onCheckoutPressed: () => cubit.proceedToCheckout(),
                    onExpressCheckoutPressed: () =>
                        cubit.initiateExpressCheckout(),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}
