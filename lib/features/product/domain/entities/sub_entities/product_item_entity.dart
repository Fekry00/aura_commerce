class ProductItemEntity {
  const ProductItemEntity({
    required this.id,
    required this.title,
    required this.price,
    this.originalPrice,
    required this.rating,
    required this.reviewsCount,
    required this.imageUrl,
    required this.stockStatus,
    required this.materialSummary,
    required this.calibreDescription,
    required this.movement,
    required this.glass,
    required this.strapMaterial,
    required this.powerReserve,
    required this.deliveryDescription,
    required this.guaranteeDescription,
    this.isFavorite = false,
  });

  final String id;
  final String title;
  final double price;
  final double? originalPrice;
  final double rating;
  final int reviewsCount;
  final String imageUrl;
  final String stockStatus;
  final String materialSummary;
  final String calibreDescription;
  final String movement;
  final String glass;
  final String strapMaterial;
  final String powerReserve;
  final String deliveryDescription;
  final String guaranteeDescription;
  final bool isFavorite;
}
