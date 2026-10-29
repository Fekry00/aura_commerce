import 'package:aura/features/cart/domain/entities/sub_entities/order_summary_entity.dart';

class OrderSummaryModel extends OrderSummaryEntity {
  const OrderSummaryModel({
    required super.itemsCount,
    required super.subtotal,
    required super.discountAmount,
    required super.shippingLabel,
    required super.tax,
    required super.taxLocation,
    required super.total,
  });

  factory OrderSummaryModel.fromJson(Map<String, dynamic> json) {
    final itemsCount =
        ((json['items_count'] ?? json['itemsCount']) as num?)?.toInt() ?? 0;
    final subtotal =
        ((json['subtotal'] ?? json['subTotal']) as num?)?.toDouble() ?? 0.0;
    final discountAmount =
        ((json['discount_amount'] ?? json['discountAmount']) as num?)
                ?.toDouble() ??
            0.0;
    final shippingLabel = (json['shipping_label'] ?? json['shippingLabel'])
            as String? ??
        'COMPLIMENTARY';
    final tax =
        ((json['tax'] ?? json['sales_tax']) as num?)?.toDouble() ?? 0.0;
    final taxLocation =
        (json['tax_location'] ?? json['taxLocation']) as String? ?? '';
    final calculatedTotal =
        (subtotal - discountAmount + tax).clamp(0.0, double.infinity);
    final total =
        ((json['total'] ?? json['total_payable']) as num?)?.toDouble() ??
            calculatedTotal;

    return OrderSummaryModel(
      itemsCount: itemsCount,
      subtotal: subtotal,
      discountAmount: discountAmount,
      shippingLabel: shippingLabel,
      tax: tax,
      taxLocation: taxLocation,
      total: total,
    );
  }

  OrderSummaryModel copyWith({
    int? itemsCount,
    double? subtotal,
    double? discountAmount,
    String? shippingLabel,
    double? tax,
    String? taxLocation,
    double? total,
  }) {
    return OrderSummaryModel(
      itemsCount: itemsCount ?? this.itemsCount,
      subtotal: subtotal ?? this.subtotal,
      discountAmount: discountAmount ?? this.discountAmount,
      shippingLabel: shippingLabel ?? this.shippingLabel,
      tax: tax ?? this.tax,
      taxLocation: taxLocation ?? this.taxLocation,
      total: total ?? this.total,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'items_count': itemsCount,
      'subtotal': subtotal,
      'discount_amount': discountAmount,
      'shipping_label': shippingLabel,
      'tax': tax,
      'tax_location': taxLocation,
      'total': total,
    };
  }
}
