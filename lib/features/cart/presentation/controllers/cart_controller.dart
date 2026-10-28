import 'package:aura/core/routing/routes.dart';
import 'package:aura/core/utils/functions/custom_snack_bar.dart';
import 'package:aura/features/cart/domain/entities/cart_entity.dart';
import 'package:aura/features/cart/presentation/cubit/cart_cubit.dart';
import 'package:aura/features/cart/presentation/widgets/cart_item_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Pure UI & Action controller for Cart presentation layer.
/// Does NOT extend ChangeNotifier; delegates state to CartCubit/CartEntity.
class CartController {
  CartEntity? _currentCart;

  final TextEditingController voucherInputController = TextEditingController();

  void dispose() {
    voucherInputController.dispose();
  }

  void updateCart(CartEntity? cart) {
    _currentCart = cart;
  }

  void setFromEntity(CartEntity? entity) => updateCart(entity);

  CartEntity? get currentCart => _currentCart;

  List<CartItemUiModel> get items {
    final cart = _currentCart;
    if (cart == null) return const [];
    return cart.items
        .map((item) => CartItemUiModel(
              id: item.id,
              category: item.category.isNotEmpty ? item.category : 'General',
              title: item.title,
              subtitle: item.subtitle,
              unitPrice: item.price,
              quantity: item.quantity,
              imageUrl: item.imageUrl,
            ))
        .toList();
  }

  bool get isEmpty => items.isEmpty;

  bool get hasDiscount =>
      _currentCart?.voucher != null ||
      ((_currentCart?.orderSummary.discountAmount ?? 0) > 0);

  String? get activeVoucherCode => _currentCart?.voucher?.code;

  String? get voucherLabel => _currentCart?.voucher?.label;

  double get voucherDiscountRate =>
      _currentCart?.voucher?.discountRate ?? 0.0;

  int get totalItemCount => _currentCart?.orderSummary.itemsCount ?? 0;

  double get subtotal => _currentCart?.orderSummary.subtotal ?? 0.0;

  double get discountAmount =>
      _currentCart?.orderSummary.discountAmount ?? 0.0;

  double get tax => _currentCart?.orderSummary.tax ?? 0.0;

  double get totalPayable => _currentCart?.orderSummary.total ?? 0.0;

  double get shippingThreshold =>
      _currentCart?.shippingMeter.threshold ?? 2000.0;

  double get shippingRemaining =>
      _currentCart?.shippingMeter.remainingAmount ?? 0.0;

  double get shippingProgressRatio =>
      _currentCart?.shippingMeter.progressRatio ?? 1.0;

  int get shippingPercent =>
      _currentCart?.shippingMeter.progressPercent ?? 100;

  bool get isShippingUnlocked =>
      _currentCart?.shippingMeter.isComplimentary ?? true;

  String get formattedSubtotal => _format(subtotal);
  String get formattedDiscount => _format(discountAmount);
  String get formattedOrderDiscount => '-$formattedDiscount';
  String get formattedDiscountPercentage =>
      '${(voucherDiscountRate * 100).round()}%';
  String get formattedTax => _format(tax);
  String get formattedTotal => _format(totalPayable);
  String get formattedShippingRemaining => _format(shippingRemaining);

  // ── Cart Actions Triggered from UI ────────────────────────────────────────
  void onIncrement(BuildContext context, CartItemUiModel item) {
    context.read<CartCubit>().updateCartItemQuantity(
          itemId: item.id,
          quantity: item.quantity + 1,
        );
  }

  void onDecrement(BuildContext context, CartItemUiModel item) {
    if (item.quantity > 1) {
      context.read<CartCubit>().updateCartItemQuantity(
            itemId: item.id,
            quantity: item.quantity - 1,
          );
    } else {
      context.read<CartCubit>().removeCartItem(item.id);
    }
  }

  void onRemove(BuildContext context, CartItemUiModel item) {
    context.read<CartCubit>().removeCartItem(item.id);
  }

  void onApplyVoucher(BuildContext context) {
    final cleanCode = voucherInputController.text.trim();
    if (cleanCode.isEmpty) {
      showCustomSnackBar(
        context,
        message: 'Please enter a promo code (e.g. WELCOME10)',
        type: SnackBarType.error,
      );
      return;
    }

    context.read<CartCubit>().applyVoucher(cleanCode);
    voucherInputController.clear();
    FocusScope.of(context).unfocus();

    showCustomSnackBar(
      context,
      message: 'Promo code applied successfully!',
      type: SnackBarType.success,
    );
  }

  void onRemoveVoucher(BuildContext context) {
    context.read<CartCubit>().removeVoucher();
    showCustomSnackBar(
      context,
      message: 'Promo code removed',
      type: SnackBarType.info,
    );
  }

  void onProceedToCheckout(BuildContext context) {
    Navigator.of(context).pushNamed(Routes.checkoutView);
  }

  void onExpressCheckout(BuildContext context) {
    showCustomSnackBar(
      context,
      message: 'Initializing Express Wallet checkout...',
      type: SnackBarType.info,
    );
  }

  static String _format(double amount) {
    return '${amount.toStringAsFixed(0)} EGP';
  }
}
