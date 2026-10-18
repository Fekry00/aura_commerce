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
    return OrderSummaryModel(
      itemsCount:
          ((json['items_count'] ?? json['itemsCount']) as num?)?.toInt() ?? 3,
      subtotal:
          ((json['subtotal'] ?? json['subTotal']) as num?)?.toDouble() ??
              2660.0,
      discountAmount: ((json['discount_amount'] ?? json['discountAmount'])
              as num?)
          ?.toDouble() ??
          266.0,
      shippingLabel: (json['shipping_label'] ?? json['shippingLabel'])
              as String? ??
          'COMPLIMENTARY',
      tax: ((json['tax'] ?? json['sales_tax']) as num?)?.toDouble() ??
          191.50,
      taxLocation: (json['tax_location'] ?? json['taxLocation'])
              as String? ??
          'NY',
      total: ((json['total'] ?? json['total_payable']) as num?)?.toDouble() ??
          2585.50,
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
