class OrderSummaryEntity {
  const OrderSummaryEntity({
    required this.itemsCount,
    required this.subtotal,
    required this.discountAmount,
    required this.shippingLabel,
    required this.tax,
    required this.taxLocation,
    required this.total,
  });

  final int itemsCount;
  final double subtotal;
  final double discountAmount;
  final String shippingLabel;
  final double tax;
  final String taxLocation;
  final double total;
}
