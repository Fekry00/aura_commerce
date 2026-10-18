class CheckoutPaymentSummaryEntity {
  const CheckoutPaymentSummaryEntity({
    required this.subtotal,
    required this.discount,
    required this.discountPercentage,
    required this.shippingFee,
    required this.tax,
    required this.total,
    required this.itemsCountText,
  });

  final String subtotal;
  final String discount;
  final String discountPercentage;
  final String shippingFee;
  final String tax;
  final String total;
  final String itemsCountText;
}
