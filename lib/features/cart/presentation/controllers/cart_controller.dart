import 'dart:math' as math;
import 'package:aura/core/routing/routes.dart';
import 'package:aura/core/utils/functions/custom_snack_bar.dart';
import 'package:aura/features/cart/domain/entities/cart_entity.dart';
import 'package:aura/features/cart/presentation/cubit/cart_cubit.dart';
import 'package:aura/features/cart/presentation/widgets/cart_item_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Pure UI & Form controller for Cart presentation layer.
/// Encapsulates items, calculations, voucher input, and cubit interactions.
class CartController extends ChangeNotifier {
  List<CartItemUiModel> _items = [];
  String? _activeVoucherCode;
  double _voucherDiscountRate = 0.0;
  String? _voucherLabel;

  final double _shippingThreshold = 2000.0;
  final double _taxRate = 0.0;

  final TextEditingController voucherInputController = TextEditingController();

  @override
  void dispose() {
    voucherInputController.dispose();
    super.dispose();
  }

  // ── Getters & Calculated Values ───────────────────────────────────────────
  double get shippingThreshold => _shippingThreshold;
  List<CartItemUiModel> get items => _items;
  String? get activeVoucherCode => _activeVoucherCode;
  double get voucherDiscountRate => _voucherDiscountRate;
  String? get voucherLabel => _voucherLabel;
  bool get isEmpty => _items.isEmpty;
  bool get hasDiscount => _activeVoucherCode != null;

  int get totalItemCount =>
      _items.fold(0, (sum, item) => sum + item.quantity);

  double get subtotal =>
      _items.fold(0.0, (sum, item) => sum + item.totalPrice);

  double get discountAmount =>
      hasDiscount ? subtotal * _voucherDiscountRate : 0.0;

  double get taxableAmount => math.max(0.0, subtotal - discountAmount);
  double get tax => taxableAmount * _taxRate;
  double get totalPayable => taxableAmount + tax;

  double get shippingRemaining =>
      math.max(0.0, _shippingThreshold - subtotal);

  double get shippingProgressRatio {
    if (_shippingThreshold <= 0) return 1.0;
    return (subtotal / _shippingThreshold).clamp(0.0, 1.0);
  }

  int get shippingPercent => (shippingProgressRatio * 100).round();
  bool get isShippingUnlocked =>
      shippingProgressRatio >= 1.0 || shippingRemaining <= 0;

  String get formattedSubtotal => _format(subtotal);
  String get formattedDiscount => _format(discountAmount);
  String get formattedOrderDiscount => '-$formattedDiscount';
  String get formattedDiscountPercentage =>
      '${(voucherDiscountRate * 100).round()}%';
  String get formattedTax => _format(tax);
  String get formattedTotal => _format(totalPayable);
  String get formattedShippingRemaining => _format(shippingRemaining);

  // ── Data Sync ─────────────────────────────────────────────────────────────
  void setFromEntity(CartEntity entity) {
    _items = entity.items
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
    notifyListeners();
  }

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

    applyVoucher(cleanCode);
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
    removeVoucher();
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

  // ── Local Model State Updaters ────────────────────────────────────────────
  void incrementQuantity(int index) {
    if (index >= 0 && index < _items.length) {
      _items[index] = _items[index].copyWith(
        quantity: _items[index].quantity + 1,
      );
      notifyListeners();
    }
  }

  void decrementQuantity(int index) {
    if (index >= 0 && index < _items.length && _items[index].quantity > 1) {
      _items[index] = _items[index].copyWith(
        quantity: _items[index].quantity - 1,
      );
      notifyListeners();
    }
  }

  void removeItem(int index) {
    if (index >= 0 && index < _items.length) {
      _items.removeAt(index);
      notifyListeners();
    }
  }

  void applyVoucher(String promoCode) {
    final cleanCode = promoCode.trim();
    if (cleanCode.isEmpty) return;

    double rate = 0.10;
    int percent = 10;

    final regExp = RegExp(r'(\d+)');
    final match = regExp.firstMatch(cleanCode);

    if (match != null) {
      final parsedNumber = int.tryParse(match.group(1)!);
      if (parsedNumber != null && parsedNumber > 0) {
        percent = parsedNumber.clamp(1, 100);
        rate = percent / 100.0;
      }
    } else {
      final upper = cleanCode.toUpperCase();
      if (upper == 'HALF') {
        percent = 50;
        rate = 0.50;
      } else if (upper == 'VIP' || upper == 'AURA') {
        percent = 20;
        rate = 0.20;
      }
    }

    _activeVoucherCode = cleanCode.toUpperCase();
    _voucherDiscountRate = rate;
    _voucherLabel = '-$percent% VIP Privilege';
    notifyListeners();
  }

  void removeVoucher() {
    _activeVoucherCode = null;
    _voucherDiscountRate = 0.0;
    _voucherLabel = null;
    notifyListeners();
  }

  void resetCart() {
    _items.clear();
    _activeVoucherCode = null;
    _voucherDiscountRate = 0.0;
    _voucherLabel = null;
    notifyListeners();
  }

  static String _format(double amount) {
    return '${amount.toStringAsFixed(0)} EGP';
  }
}
