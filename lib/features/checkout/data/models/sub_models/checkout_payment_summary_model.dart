import 'package:aura/features/checkout/domain/entities/sub_entities/checkout_payment_summary_entity.dart';

class CheckoutPaymentSummaryModel extends CheckoutPaymentSummaryEntity {
  const CheckoutPaymentSummaryModel({
    required super.subtotal,
    required super.discount,
    required super.discountPercentage,
    required super.shippingFee,
    required super.tax,
    required super.total,
    required super.itemsCountText,
  });

  factory CheckoutPaymentSummaryModel.fromJson(Map<String, dynamic> json) {
    return CheckoutPaymentSummaryModel(
      subtotal: json['subtotal'] as String? ?? '\$0.00',
      discount: json['discount'] as String? ?? '-\$0.00',
      discountPercentage: (json['discount_percentage'] ?? json['discountPercentage']) as String? ?? '0% OFF',
      shippingFee: (json['shipping_fee'] ?? json['shippingFee']) as String? ?? 'Free',
      tax: json['tax'] as String? ?? '\$0.00',
      total: json['total'] as String? ?? '\$0.00',
      itemsCountText: (json['items_count_text'] ?? json['itemsCountText']) as String? ?? '0 Items Selected',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'subtotal': subtotal,
      'discount': discount,
      'discount_percentage': discountPercentage,
      'shipping_fee': shippingFee,
      'tax': tax,
      'total': total,
      'items_count_text': itemsCountText,
    };
  }
}
