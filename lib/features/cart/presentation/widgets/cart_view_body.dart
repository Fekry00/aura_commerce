import 'package:aura/core/theme/app_colors.dart';
import 'package:aura/core/theme/app_typography.dart';
import 'package:aura/features/cart/presentation/cubit/cart_cubit.dart';
import 'package:aura/features/cart/presentation/cubit/cart_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
      child: BlocConsumer<CartCubit, CartState>(
        listener: (context, state) {
          if (state is CartSuccessState) {
            _controller.setFromEntity(state.cart);
          }
        },
        builder: (context, state) {
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
                              Container(
                                height: 200,
                                alignment: Alignment.center,
                                child: const CircularProgressIndicator(
                                  color: AppColors.primary,
                                ),
                              ),
                            ] else if (_controller.isEmpty) ...[
                              Container(
                                height: 260,
                                alignment: Alignment.center,
                                padding: const EdgeInsets.symmetric(horizontal: 32),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.shopping_bag_outlined,
                                      size: 56,
                                      color: AppColors.onSurfaceVariant.withValues(alpha: 0.4),
                                    ),
                                    const SizedBox(height: 12),
                                    Text(
                                      'Your Cart is Empty',
                                      style: AppTypography.headlineSm.copyWith(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 16,
                                      ),
                                    ),
                                    const SizedBox(height: 6),
                                    Text(
                                      'Discover iconic products and tap (+) on any item to add it to your bag.',
                                      textAlign: TextAlign.center,
                                      style: AppTypography.bodySm.copyWith(
                                        color: AppColors.onSurfaceVariant,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ] else ...[
                              CartShippingMeterCard(controller: _controller),
                              const SizedBox(height: AppSpacing.spaceMd),
                              CartItemsListSection(
                                controller: _controller,
                                onIncrement: (index) {
                                  final item = _controller.items[index];
                                  context.read<CartCubit>().updateCartItemQuantity(
                                        itemId: item.id,
                                        quantity: item.quantity + 1,
                                      );
                                },
                                onDecrement: (index) {
                                  final item = _controller.items[index];
                                  if (item.quantity > 1) {
                                    context.read<CartCubit>().updateCartItemQuantity(
                                          itemId: item.id,
                                          quantity: item.quantity - 1,
                                        );
                                  } else {
                                    context.read<CartCubit>().removeCartItem(item.id);
                                  }
                                },
                                onRemove: (index) {
                                  final item = _controller.items[index];
                                  context.read<CartCubit>().removeCartItem(item.id);
                                },
                              ),
                              const SizedBox(height: AppSpacing.spaceMd),
                              CartVoucherSection(controller: _controller),
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
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}
