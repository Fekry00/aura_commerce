class OrderSettlementSummaryEntity {
  const OrderSettlementSummaryEntity({
    required this.subtotal,
    required this.itemsCount,
    required this.privilegeDiscount,
    required this.privilegeCode,
    required this.courierTransitFee,
    required this.courierBadge,
    required this.dutiesAndHandling,
    required this.totalAmountPaid,
    required this.paymentMethod,
    this.isEscrowConfirmed = true,
  });

  final String subtotal;
  final int itemsCount;
  final String privilegeDiscount;
  final String privilegeCode;
  final String courierTransitFee;
  final String courierBadge;
  final String dutiesAndHandling;
  final String totalAmountPaid;
  final String paymentMethod;
  final bool isEscrowConfirmed;
}
