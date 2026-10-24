class ProductItemEntity {
  const ProductItemEntity({
    required this.id,
    required this.name,
    this.slug,
    this.description,
    this.thumbnailUrl,
    this.images = const [],
    required this.minPrice,
    this.compareAtPrice,
    this.discountPercent,
    this.stock,
    this.inStock = true,
    this.isActive = true,
    this.isDisabled = false,
    this.isFeatured = false,
    this.isBestSeller = false,
    this.categoryId,
    this.categoryName,
    this.rating = 4.9,
    this.reviewsCount = 120,
    this.isFavorite = false,
  });

  final int id;
  final String name;
  final String? slug;
  final String? description;
  final String? thumbnailUrl;
  final List<String> images;
  final num minPrice;
  final num? compareAtPrice;
  final num? discountPercent;
  final int? stock;
  final bool inStock;
  final bool isActive;
  final bool isDisabled;
  final bool isFeatured;
  final bool isBestSeller;
  final int? categoryId;
  final String? categoryName;
  final double rating;
  final int reviewsCount;
  final bool isFavorite;

  // Convenience getters for UI compatibility
  String get title => name;
  double get price => minPrice.toDouble();
  double? get originalPrice => compareAtPrice?.toDouble();
  String get imageUrl =>
      thumbnailUrl ?? (images.isNotEmpty ? images.first : '');
  String get stockStatus => inStock ? 'IN STOCK' : 'OUT OF STOCK';
}
