class WishlistItemEntity {
  const WishlistItemEntity({
    required this.id,
    required this.title,
    required this.category,
    required this.price,
    this.originalPrice,
    required this.imageUrl,
    this.badge,
    required this.stockStatus,
    this.isLowStock = false,
    this.hasComplimentary = false,
  });

  final String id;
  final String title;
  final String category;
  final double price;
  final double? originalPrice;
  final String imageUrl;
  final String? badge;
  final String stockStatus;
  final bool isLowStock;
  final bool hasComplimentary;
}
