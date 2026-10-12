import 'dart:math' as math;
import 'package:aura/features/cart/presentation/widgets/cart_item_card.dart';
import 'package:flutter/foundation.dart';

class CartController extends ChangeNotifier {
  static const List<CartItemUiModel> initialItems = [
    CartItemUiModel(
      id: 'item_1',
      category: 'HOROLOGY',
      title: 'Aethel Minimalist Chronograph',
      subtitle: 'Brushed Titanium • 40mm',
      unitPrice: 1450.00,
      quantity: 1,
      imageUrl:
          'https://lh3.googleusercontent.com/aida-public/AB6AXuDD0sbnNVvsv33yBAnoqPB20Vs7jx_Bj8lrn6GPRWyjaiVPYFvMjgfhitJOdJa_e3iNRbQl4cxRWwt0yEj0sLuRq-yCgOIxFtwssw9ylmZNFpkGom4eQiQoQxdrnKt94SI5N-N3yNHthLaG9q0PzQWohNcVO_UcaRu7gqz066HwD0YLLELX7PCOtQL2HXflN219MVpetlDdx8hDSQd4XLoHLMIPXCT0rOP_8dMk6s31A7WaQsGiUdo8',
    ),
    CartItemUiModel(
      id: 'item_2',
      category: 'LEATHER GOODS',
      title: 'Verona Nappa Leather Tote',
      subtitle: 'Forest Green • One Size',
      unitPrice: 890.00,
      quantity: 1,
      imageUrl:
          'https://lh3.googleusercontent.com/aida-public/AB6AXuAC9S5sow3Mq93k0DT7B6_MTu4V_ZluO8KoBzdbylC-FlrceCygBoyXqVaLh6JfBU-pyeiwrmcJuYOUv33Qi-vxd64NW4Bb6qaWPDo5xb06Bsx87XLpj1n7zZ68m9dHzPSkRJZuhYQ9MrISpLwq4IAD3g4T6LcSFG3SLcnzkonYx-jpQBoI_z0j4K6-co3FpCTBnsB9Rkgu4nk89bsIcxRQ2ShVM3j1GIm2s3EwUY-qRLuXXR5OWgzz',
    ),
    CartItemUiModel(
      id: 'item_3',
      category: 'HAUTE PARFUMERIE',
      title: 'Oud & Bergamot Extrait',
      subtitle: 'Vaporisateur • 100ml',
      unitPrice: 320.00,
      quantity: 1,
      imageUrl:
          'https://lh3.googleusercontent.com/aida-public/AB6AXuAqtKu1r4CebpmbxvF1DkyXyGNKfTabhgzCOJg8lk4E7dL1IS8X6mFcEZU1leREKXX0yqU6Ub3Bsc8ZosCVRhIHPL9yltAz9ddZn00ISNYsCflqb45H-LFn728wZD5bsTXf-DGCA5jqZqVTsJgq7psnSRBCbl9F-tW6hNC5j0j4Mx4gPaI9NmjQCBkMX3nuNndZnGV2j0UwPvsXHkwOcG9Pr5ox-5OxNqyrK4m9jirzKXKfGXKmaNvG',
    ),
  ];

  List<CartItemUiModel> _items = List.from(initialItems);
  String? _activeVoucherCode = 'WELCOME10';
  double _voucherDiscountRate = 0.10;
  String? _voucherLabel = '-10% VIP Privilege';

  final double _shippingThreshold = 2710.0;
  final double _taxRate = 0.08;

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

  String get formattedSubtotal => _format(subtotal);
  String get formattedDiscount => _format(discountAmount);
  String get formattedTax => _format(tax);
  String get formattedTotal => _format(totalPayable);
  String get formattedShippingRemaining => _format(shippingRemaining);

  void incrementQuantity(int index) {
    _items[index] = _items[index].copyWith(
      quantity: _items[index].quantity + 1,
    );
    notifyListeners();
  }

  void decrementQuantity(int index) {
    if (_items[index].quantity > 1) {
      _items[index] = _items[index].copyWith(
        quantity: _items[index].quantity - 1,
      );
      notifyListeners();
    }
  }

  void removeItem(int index) {
    _items.removeAt(index);
    notifyListeners();
  }

  void applyVoucher(String promoCode) {
    final upper = promoCode.trim().toUpperCase();
    if (upper.isEmpty) return;

    double rate = 0.10;
    String label = '-10% VIP Privilege';

    if (upper.contains('15')) {
      rate = 0.15;
      label = '-15% VIP Privilege';
    } else if (upper.contains('20')) {
      rate = 0.20;
      label = '-20% VIP Privilege';
    } else if (upper.contains('5')) {
      rate = 0.05;
      label = '-5% VIP Privilege';
    }

    _activeVoucherCode = upper;
    _voucherDiscountRate = rate;
    _voucherLabel = label;
    notifyListeners();
  }

  void removeVoucher() {
    _activeVoucherCode = null;
    _voucherDiscountRate = 0.0;
    _voucherLabel = null;
    notifyListeners();
  }

  void resetCart() {
    _items = List.from(initialItems);
    _activeVoucherCode = 'WELCOME10';
    _voucherDiscountRate = 0.10;
    _voucherLabel = '-10% VIP Privilege';
    notifyListeners();
  }

  static String _format(double amount) {
    final parts = amount.toStringAsFixed(2).split('.');
    final intPart = parts[0].replaceAllMapped(
      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
      (Match m) => '${m[1]},',
    );
    return '\$$intPart.${parts[1]}';
  }
}
