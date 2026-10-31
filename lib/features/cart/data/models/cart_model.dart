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

    const double defaultThreshold = 2000.0;
    const double standardShippingFee = 50.0;
    final double freeShippingThreshold = json['shipping_meter'] is Map<String, dynamic>
        ? (((json['shipping_meter'] as Map<String, dynamic>)['threshold'] ??
                defaultThreshold) as num)
            .toDouble()
        : defaultThreshold;

    final bool isComplimentaryShipping =
        itemsList.isNotEmpty && summarySubtotal >= freeShippingThreshold;
    final double remainingShippingAmount = isComplimentaryShipping || itemsList.isEmpty
        ? (itemsList.isEmpty ? freeShippingThreshold : 0.0)
        : (freeShippingThreshold - summarySubtotal).clamp(0.0, freeShippingThreshold);
    final double shippingProgressRatio = itemsList.isEmpty
        ? 0.0
        : (summarySubtotal / freeShippingThreshold).clamp(0.0, 1.0);
    final int shippingProgressPercent = (shippingProgressRatio * 100).round();
    final double shippingFee = itemsList.isEmpty || isComplimentaryShipping
        ? 0.0
        : standardShippingFee;

    final shippingMeterModel = ShippingMeterModel(
      remainingAmount: remainingShippingAmount,
      threshold: freeShippingThreshold,
      progressRatio: shippingProgressRatio,
      progressPercent: shippingProgressPercent,
      message: isComplimentaryShipping
          ? 'Complimentary Express Courier Unlocked 🎉'
          : 'Add ${remainingShippingAmount.toStringAsFixed(0)} EGP more for Complimentary Express Courier',
      isComplimentary: isComplimentaryShipping,
    );

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

    final shippingLabel = isComplimentaryShipping
        ? 'COMPLIMENTARY'
        : (itemsList.isEmpty ? '-' : '${shippingFee.toStringAsFixed(0)} EGP');

    final tax = ((summaryMap?['tax'] ?? summaryMap?['sales_tax']) as num?)
            ?.toDouble() ??
        0.0;

    final taxLocation = (summaryMap?['tax_location'] ??
            summaryMap?['taxLocation'] ??
            json['tax_location']) as String? ??
        '';

    final calculatedTotal = (summarySubtotal - discountAmount + tax + shippingFee)
        .clamp(0.0, double.infinity);

    final total = calculatedTotal;

    return CartModel(
      curatedBadge: (dataMap['curated_badge'] ??
              dataMap['curatedBadge'] ??
              json['curated_badge'] ??
              json['curatedBadge']) as String? ??
          '${itemsList.length} CURATED ITEMS',
      shippingMeter: shippingMeterModel,
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
    const double freeShippingThreshold = 2000.0;
    const double standardShippingFee = 50.0;

    final subtotal = orderSummary.subtotal;
    final bool isComplimentary = items.isNotEmpty && subtotal >= freeShippingThreshold;
    final double remaining = isComplimentary || items.isEmpty
        ? (items.isEmpty ? freeShippingThreshold : 0.0)
        : (freeShippingThreshold - subtotal).clamp(0.0, freeShippingThreshold);
    final double progressRatio = items.isEmpty
        ? 0.0
        : (subtotal / freeShippingThreshold).clamp(0.0, 1.0);
    final int progressPercent = (progressRatio * 100).round();
    final double shippingFee = items.isEmpty || isComplimentary ? 0.0 : standardShippingFee;
    final String shippingLabel = isComplimentary
        ? 'COMPLIMENTARY'
        : (items.isEmpty ? '-' : '${standardShippingFee.toStringAsFixed(0)} EGP');

    final updatedShippingMeter = ShippingMeterModel(
      remainingAmount: remaining,
      threshold: freeShippingThreshold,
      progressRatio: progressRatio,
      progressPercent: progressPercent,
      message: isComplimentary
          ? 'Complimentary Express Courier Unlocked 🎉'
          : 'Add ${remaining.toStringAsFixed(0)} EGP more for Complimentary Express Courier',
      isComplimentary: isComplimentary,
    );

    if (newVoucher == null) {
      final newTotal = (subtotal + orderSummary.tax + shippingFee)
          .clamp(0.0, double.infinity);
      return CartModel(
        curatedBadge: curatedBadge,
        shippingMeter: updatedShippingMeter,
        items: items.map((e) => e as CartItemModel).toList(),
        voucher: null,
        orderSummary: (orderSummary as OrderSummaryModel).copyWith(
          discountAmount: 0.0,
          shippingLabel: shippingLabel,
          total: newTotal,
        ),
      );
    }

    double discount = 0.0;
    if (newVoucher.type == 'fixed') {
      discount = newVoucher.value <= subtotal
          ? newVoucher.value
          : subtotal;
    } else {
      discount = subtotal * newVoucher.discountRate;
    }

    final newTotal = (subtotal - discount + orderSummary.tax + shippingFee)
        .clamp(0.0, double.infinity);

    return CartModel(
      curatedBadge: curatedBadge,
      shippingMeter: updatedShippingMeter,
      items: items.map((e) => e as CartItemModel).toList(),
      voucher: newVoucher,
      orderSummary: (orderSummary as OrderSummaryModel).copyWith(
        discountAmount: discount,
        shippingLabel: shippingLabel,
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
