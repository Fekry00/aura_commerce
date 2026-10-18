import 'package:aura/features/orders/domain/entities/sub_entities/order_settlement_summary_entity.dart';

class OrderSettlementSummaryModel extends OrderSettlementSummaryEntity {
  const OrderSettlementSummaryModel({
    required super.subtotal,
    required super.itemsCount,
    required super.privilegeDiscount,
    required super.privilegeCode,
    required super.courierTransitFee,
    required super.courierBadge,
    required super.dutiesAndHandling,
    required super.totalAmountPaid,
    required super.paymentMethod,
    super.isEscrowConfirmed = true,
  });

  factory OrderSettlementSummaryModel.fromJson(Map<String, dynamic> json) {
    return OrderSettlementSummaryModel(
      subtotal: json['subtotal'] as String? ?? '\$0.00',
      itemsCount: (json['items_count'] ?? json['itemsCount'] as num?)?.toInt() ?? 0,
      privilegeDiscount: (json['privilege_discount'] ?? json['privilegeDiscount']) as String? ?? '-\$0.00',
      privilegeCode: (json['privilege_code'] ?? json['privilegeCode']) as String? ?? '',
      courierTransitFee: (json['courier_transit_fee'] ?? json['courierTransitFee']) as String? ?? '\$0.00',
      courierBadge: (json['courier_badge'] ?? json['courierBadge']) as String? ?? 'VIP COMPLIMENTARY',
      dutiesAndHandling: (json['duties_and_handling'] ?? json['dutiesAndHandling']) as String? ?? '\$0.00',
      totalAmountPaid: (json['total_amount_paid'] ?? json['totalAmountPaid']) as String? ?? '\$0.00',
      paymentMethod: (json['payment_method'] ?? json['paymentMethod']) as String? ?? '',
      isEscrowConfirmed: (json['is_escrow_confirmed'] ?? json['isEscrowConfirmed']) as bool? ?? true,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'subtotal': subtotal,
      'items_count': itemsCount,
      'privilege_discount': privilegeDiscount,
      'privilege_code': privilegeCode,
      'courier_transit_fee': courierTransitFee,
      'courier_badge': courierBadge,
      'duties_and_handling': dutiesAndHandling,
      'total_amount_paid': totalAmountPaid,
      'payment_method': paymentMethod,
      'is_escrow_confirmed': isEscrowConfirmed,
    };
  }
}
