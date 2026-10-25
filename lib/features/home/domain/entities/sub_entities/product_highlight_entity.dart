import 'product_rating_entity.dart';

class ProductHighlightEntity {
  const ProductHighlightEntity({
    required this.id,
    required this.title,
    required this.price,
    required this.imageUrl,
    required this.rating,
    this.badge,
    this.isFavorite = false,
    this.isPopular = false,
    this.categoryId,
    this.categoryName,
  });

  final String id;
  final String title;
  final double price;
  final String imageUrl;
  final ProductRatingEntity rating;
  final String? badge;
  final bool isFavorite;
  final bool isPopular;
  final int? categoryId;
  final String? categoryName;
}