import 'sub_entities/cart_item_entity.dart';
import 'sub_entities/order_summary_entity.dart';
import 'sub_entities/shipping_meter_entity.dart';
import 'sub_entities/voucher_entity.dart';

class CartEntity {
  const CartEntity({
    required this.curatedBadge,
    required this.shippingMeter,
    required this.items,
    this.voucher,
    required this.orderSummary,
  });

  final String curatedBadge;
  final ShippingMeterEntity shippingMeter;
  final List<CartItemEntity> items;
  final VoucherEntity? voucher;
  final OrderSummaryEntity orderSummary;

  bool get isEmpty => items.isEmpty;
  bool get hasDiscount => orderSummary.discountAmount > 0;
  String? get activeVoucherCode => voucher?.code;
  String? get voucherLabel => voucher?.label;
  double get voucherDiscountRate {
    if (voucher != null && voucher!.discountRate > 0) {
      return voucher!.discountRate;
    }
    if (orderSummary.subtotal > 0 && orderSummary.discountAmount > 0) {
      return orderSummary.discountAmount / orderSummary.subtotal;
    }
    return 0.0;
  }

  String get formattedSubtotal =>
      '${orderSummary.subtotal.toStringAsFixed(0)} EGP';
  String get formattedDiscount =>
      '${orderSummary.discountAmount.toStringAsFixed(0)} EGP';
  String get formattedOrderDiscount => '-$formattedDiscount';
  String get formattedDiscountPercentage =>
      '${(voucherDiscountRate * 100).round()}%';
  String get formattedTax => '${orderSummary.tax.toStringAsFixed(0)} EGP';
  String get formattedTotal => '${orderSummary.total.toStringAsFixed(0)} EGP';
  String get formattedShippingRemaining =>
      '${shippingMeter.remainingAmount.toStringAsFixed(0)} EGP';
}

