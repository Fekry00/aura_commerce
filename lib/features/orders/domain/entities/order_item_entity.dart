class OrderItemEntity {
  const OrderItemEntity({
    required this.id,
    required this.productId,
    required this.productName,
    this.productSlug,
    this.productThumbnail,
    required this.quantity,
    required this.price,
    required this.itemTotal,
  });

  final int id;
  final int productId;
  final String productName;
  final String? productSlug;
  final String? productThumbnail;
  final int quantity;
  final double price;
  final double itemTotal;
}
