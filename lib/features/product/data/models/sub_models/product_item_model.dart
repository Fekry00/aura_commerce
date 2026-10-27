import 'package:aura/core/network/api/end_points.dart';
import 'package:aura/features/product/domain/entities/sub_entities/product_item_entity.dart';

class ProductItemModel extends ProductItemEntity {
  const ProductItemModel({
    required super.id,
    required super.name,
    super.slug,
    super.description,
    super.thumbnailUrl,
    super.images = const [],
    required super.minPrice,
    super.compareAtPrice,
    super.discountPercent,
    super.stock,
    super.inStock = true,
    super.isActive = true,
    super.isDisabled = false,
    super.isFeatured = false,
    super.isBestSeller = false,
    super.categoryId,
    super.categoryName,
    super.rating = 4.9,
    super.reviewsCount = 120,
    super.isFavorite = false,
  });

  factory ProductItemModel.fromJson(Map<String, dynamic> json) {
    final categoryMap = json['category'] is Map<String, dynamic>
        ? json['category'] as Map<String, dynamic>
        : null;

    final imagesList = (json['images'] as List<dynamic>? ?? [])
        .map((e) => EndPoint.fixImageUrl(e.toString()))
        .toList();

    final idVal = json['id'] is int
        ? json['id'] as int
        : int.tryParse(json['id']?.toString() ?? '1') ?? 1;

    final nameVal =
        (json['name'] ?? json['title']) as String? ?? 'Product #$idVal';

    final rawThumb = (json['thumbnailUrl'] ??
        json['thumbnail_url'] ??
        json['imageUrl'] ??
        json['image_url'] ??
        json['image']) as String?;
    final thumb = EndPoint.fixImageUrl(rawThumb);

    final minPriceVal = (json['minPrice'] ??
            json['min_price'] ??
            json['price']) as num? ??
        0;

    final comparePriceVal = (json['compareAtPrice'] ??
        json['compare_at_price'] ??
        json['originalPrice'] ??
        json['original_price']) as num?;

    final discPercent = (json['discountPercent'] ??
        json['discount_percent']) as num?;

    final stockVal = (json['stock'] as num?)?.toInt();
    final inStockVal = json['inStock'] as bool? ??
        (json['in_stock'] as bool? ??
            (stockVal == null ? true : stockVal > 0));

    return ProductItemModel(
      id: idVal,
      name: nameVal,
      slug: json['slug'] as String?,
      description: json['description'] as String?,
      thumbnailUrl: thumb,
      images: imagesList,
      minPrice: minPriceVal,
      compareAtPrice: comparePriceVal,
      discountPercent: discPercent,
      stock: stockVal,
      inStock: inStockVal,
      isActive: json['isActive'] as bool? ??
          (json['is_active'] as bool? ?? true),
      isDisabled: json['isDisabled'] as bool? ??
          (json['is_disabled'] as bool? ?? false),
      isFeatured: json['isFeatured'] as bool? ??
          (json['is_featured'] as bool? ?? false),
      isBestSeller: json['isBestSeller'] as bool? ??
          (json['is_best_seller'] as bool? ?? false),
      categoryId: categoryMap != null
          ? (categoryMap['id'] is int
              ? categoryMap['id'] as int
              : int.tryParse(categoryMap['id']?.toString() ?? ''))
          : (json['category_id'] is int
              ? json['category_id'] as int
              : int.tryParse(json['category_id']?.toString() ?? '')),
      categoryName: categoryMap?['name'] as String?,
      rating: (json['rating'] as num?)?.toDouble() ?? 4.9,
      reviewsCount:
          ((json['reviewsCount'] ?? json['reviews_count'] ?? json['reviews'])
                  as num?)
              ?.toInt() ??
          120,
      isFavorite: (json['isFavorite'] ?? json['is_favorite']) as bool? ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'slug': slug,
      'description': description,
      'thumbnailUrl': thumbnailUrl,
      'images': images,
      'minPrice': minPrice,
      'compareAtPrice': compareAtPrice,
      'discountPercent': discountPercent,
      'stock': stock,
      'inStock': inStock,
      'isActive': isActive,
      'isDisabled': isDisabled,
      'isFeatured': isFeatured,
      'isBestSeller': isBestSeller,
      'category': categoryId != null || categoryName != null
          ? {'id': categoryId, 'name': categoryName}
          : null,
      'rating': rating,
      'reviewsCount': reviewsCount,
      'isFavorite': isFavorite,
    };
  }
}
