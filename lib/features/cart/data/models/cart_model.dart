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

    final voucher = (json['voucher'] ?? json['voucher_privilege']) != null
        ? VoucherModel.fromJson(
            (json['voucher'] ?? json['voucher_privilege'])
                as Map<String, dynamic>,
          )
        : null;

    double discountAmount = ((summaryMap?['discount_amount'] ??
            summaryMap?['discountAmount']) as num?)
        ?.toDouble() ??
        0.0;

    if (discountAmount == 0.0 && voucher != null) {
      if (voucher.type == 'fixed') {
        discountAmount = voucher.value <= summarySubtotal
            ? voucher.value
            : summarySubtotal;
      } else {
        discountAmount = summarySubtotal * voucher.discountRate;
      }
    }

    final shippingLabel = (summaryMap?['shipping_label'] ??
            summaryMap?['shippingLabel'] ??
            json['shipping_label']) as String? ??
        'COMPLIMENTARY';

    final tax = ((summaryMap?['tax'] ?? summaryMap?['sales_tax']) as num?)
            ?.toDouble() ??
        0.0;

    final taxLocation = (summaryMap?['tax_location'] ??
            summaryMap?['taxLocation'] ??
            json['tax_location']) as String? ??
        '';

    final calculatedTotal = (summarySubtotal - discountAmount + tax)
        .clamp(0.0, double.infinity);

    final total = ((summaryMap?['total'] ?? summaryMap?['total_payable'])
            as num?)
        ?.toDouble() ??
        calculatedTotal;

    return CartModel(
      curatedBadge: (dataMap['curated_badge'] ??
              dataMap['curatedBadge'] ??
              json['curated_badge'] ??
              json['curatedBadge']) as String? ??
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
      voucher: voucher,
      orderSummary: OrderSummaryModel(
        itemsCount: summaryItemsCount,
        subtotal: summarySubtotal,
        discountAmount: discountAmount,
        shippingLabel: shippingLabel,
        tax: tax,
        taxLocation: taxLocation,
        total: total,
      ),
    );
  }

  CartModel applyVoucher(VoucherModel? newVoucher) {
    if (newVoucher == null) {
      final newTotal = (orderSummary.subtotal + orderSummary.tax)
          .clamp(0.0, double.infinity);
      return CartModel(
        curatedBadge: curatedBadge,
        shippingMeter: shippingMeter as ShippingMeterModel,
        items: items.map((e) => e as CartItemModel).toList(),
        voucher: null,
        orderSummary: (orderSummary as OrderSummaryModel).copyWith(
          discountAmount: 0.0,
          total: newTotal,
        ),
      );
    }

    double discount = 0.0;
    if (newVoucher.type == 'fixed') {
      discount = newVoucher.value <= orderSummary.subtotal
          ? newVoucher.value
          : orderSummary.subtotal;
    } else {
      discount = orderSummary.subtotal * newVoucher.discountRate;
    }

    final newTotal = (orderSummary.subtotal - discount + orderSummary.tax)
        .clamp(0.0, double.infinity);

    return CartModel(
      curatedBadge: curatedBadge,
      shippingMeter: shippingMeter as ShippingMeterModel,
      items: items.map((e) => e as CartItemModel).toList(),
      voucher: newVoucher,
      orderSummary: (orderSummary as OrderSummaryModel).copyWith(
        discountAmount: discount,
        total: newTotal,
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
