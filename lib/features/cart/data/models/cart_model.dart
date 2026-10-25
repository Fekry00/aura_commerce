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
    final dataMap = json['data'] is Map<String, dynamic>
        ? json['data'] as Map<String, dynamic>
        : json;

    final rawItems = (dataMap['items'] ?? json['items'] ?? (json['data'] is List ? json['data'] : [])) as List<dynamic>? ?? [];
    final itemsList = rawItems
        .map((e) => CartItemModel.fromJson(e as Map<String, dynamic>))
        .toList();

    final summaryMap = dataMap['summary'] is Map<String, dynamic>
        ? dataMap['summary'] as Map<String, dynamic>
        : (dataMap['order_summary'] is Map<String, dynamic>
            ? dataMap['order_summary'] as Map<String, dynamic>
            : (json['order_summary'] is Map<String, dynamic>
                ? json['order_summary'] as Map<String, dynamic>
                : null));

    final calculatedSubtotal = itemsList.fold<double>(
      0.0,
      (sum, item) => sum + (item.price * item.quantity),
    );

    final summaryItemsCount = ((summaryMap?['itemsCount'] ?? summaryMap?['items_count']) as num?)?.toInt() ?? itemsList.length;
    final summarySubtotal = ((summaryMap?['subtotal'] ?? summaryMap?['subTotal']) as num?)?.toDouble() ?? calculatedSubtotal;

    return CartModel(
      curatedBadge: (dataMap['curated_badge'] ?? dataMap['curatedBadge'] ?? json['curated_badge'] ?? json['curatedBadge'])
              as String? ??
          '${itemsList.length} CURATED ITEMS',
      shippingMeter: json['shipping_meter'] is Map<String, dynamic>
          ? ShippingMeterModel.fromJson(
              json['shipping_meter'] as Map<String, dynamic>,
            )
          : const ShippingMeterModel(
              remainingAmount: 0.0,
              threshold: 2000.0,
              progressRatio: 1.0,
              progressPercent: 100,
              message: 'Complimentary Express Courier Included',
              isComplimentary: true,
            ),
      items: itemsList,
      voucher: (json['voucher'] ?? json['voucher_privilege']) != null
          ? VoucherModel.fromJson(
              (json['voucher'] ?? json['voucher_privilege'])
                  as Map<String, dynamic>,
            )
          : null,
      orderSummary: summaryMap != null
          ? OrderSummaryModel.fromJson({
              ...summaryMap,
              'subtotal': summarySubtotal,
              'itemsCount': summaryItemsCount,
              'total': summarySubtotal,
            })
          : OrderSummaryModel(
              itemsCount: itemsList.length,
              subtotal: calculatedSubtotal,
              discountAmount: 0.0,
              shippingLabel: 'COMPLIMENTARY',
              tax: 0.0,
              taxLocation: 'CA',
              total: calculatedSubtotal,
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
