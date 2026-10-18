import 'package:aura/features/cart/domain/entities/cart_entity.dart';

import 'sub_models/cart_item_model.dart';
import 'sub_models/order_summary_model.dart';
import 'sub_models/shipping_meter_model.dart';
import 'sub_models/voucher_model.dart';

class CartModel extends CartEntity {
  const CartModel({
    required super.curatedBadge,
    required ShippingMeterModel super.shippingMeter,
    required List<CartItemModel> super.items,
    VoucherModel? super.voucher,
    required OrderSummaryModel super.orderSummary,
  });

  factory CartModel.fromJson(Map<String, dynamic> json) {
    return CartModel(
      curatedBadge: (json['curated_badge'] ?? json['curatedBadge'])
              as String? ??
          '3 CURATED ITEMS',
      shippingMeter: json['shipping_meter'] is Map<String, dynamic>
          ? ShippingMeterModel.fromJson(
              json['shipping_meter'] as Map<String, dynamic>,
            )
          : const ShippingMeterModel(
              remainingAmount: 50.0,
              threshold: 2710.0,
              progressRatio: 0.85,
              progressPercent: 85,
              message: 'Add \$50.00 more for Complimentary Express Courier',
              isComplimentary: false,
            ),
      items: (json['items'] as List<dynamic>? ?? [])
          .map((e) => CartItemModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      voucher: (json['voucher'] ?? json['voucher_privilege']) != null
          ? VoucherModel.fromJson(
              (json['voucher'] ?? json['voucher_privilege'])
                  as Map<String, dynamic>,
            )
          : null,
      orderSummary: json['order_summary'] is Map<String, dynamic>
          ? OrderSummaryModel.fromJson(
              json['order_summary'] as Map<String, dynamic>,
            )
          : const OrderSummaryModel(
              itemsCount: 3,
              subtotal: 2660.0,
              discountAmount: 266.0,
              shippingLabel: 'COMPLIMENTARY',
              tax: 191.50,
              taxLocation: 'NY',
              total: 2585.50,
            ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'curated_badge': curatedBadge,
      'shipping_meter': (shippingMeter as ShippingMeterModel).toJson(),
      'items': items.map((e) => (e as CartItemModel).toJson()).toList(),
      'voucher': (voucher as VoucherModel?)?.toJson(),
      'order_summary': (orderSummary as OrderSummaryModel).toJson(),
    };
  }
}
