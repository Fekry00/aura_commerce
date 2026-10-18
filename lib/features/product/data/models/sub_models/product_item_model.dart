import 'package:aura/features/product/domain/entities/sub_entities/product_item_entity.dart';

class ProductItemModel extends ProductItemEntity {
  const ProductItemModel({
    required super.id,
    required super.title,
    required super.price,
    super.originalPrice,
    required super.rating,
    required super.reviewsCount,
    required super.imageUrl,
    required super.stockStatus,
    required super.materialSummary,
    required super.calibreDescription,
    required super.movement,
    required super.glass,
    required super.strapMaterial,
    required super.powerReserve,
    required super.deliveryDescription,
    required super.guaranteeDescription,
    super.isFavorite = false,
  });

  factory ProductItemModel.fromJson(Map<String, dynamic> json) {
    return ProductItemModel(
      id: json['id']?.toString() ?? '1',
      title: json['title'] as String? ?? 'Aethel Minimalist Chronograph 40mm',
      price: (json['price'] as num?)?.toDouble() ?? 1450.0,
      originalPrice: (json['original_price'] as num?)?.toDouble(),
      rating: (json['rating'] as num?)?.toDouble() ?? 4.9,
      reviewsCount:
          ((json['reviews_count'] ?? json['reviews']) as num?)?.toInt() ?? 128,
      imageUrl: (json['image_url'] ?? json['image']) as String? ??
          'https://images.unsplash.com/photo-1523275335684-37898b6baf30?q=80&w=600',
      stockStatus: (json['stock_status'] ?? json['stockStatus']) as String? ??
          'IN STOCK',
      materialSummary: (json['material_summary'] ?? json['materialSummary'])
              as String? ??
          'Machined from monolithic 316L cold-forged stainless steel with dual-domed anti-reflective sapphire crystal, engineered to 5 ATM water resistance.',
      calibreDescription: (json['calibre_description'] ??
              json['calibreDescription']) as String? ??
          'The Aethel Minimalist Chronograph reconciles classic horology with brutalist purity. Featuring custom counterpoised sub-dials and a high-beat automatic movement tuned to +/- 3 seconds daily variance.',
      movement: json['movement'] as String? ?? 'Calibre AT-902 Autowind',
      glass: json['glass'] as String? ?? '9H Sapphire Crystal',
      strapMaterial: (json['strap_material'] ?? json['strapMaterial'])
              as String? ??
          'Full-grain Horween Leather',
      powerReserve:
          (json['power_reserve'] ?? json['powerReserve']) as String? ??
              '44-Hour Reserve',
      deliveryDescription: (json['delivery_description'] ??
              json['deliveryDescription']) as String? ??
          'Dispatched via secure armored courier within 24 hours. Transit time 2-3 business days worldwide with door-to-door full valuation insurance.',
      guaranteeDescription: (json['guarantee_description'] ??
              json['guaranteeDescription']) as String? ??
          'Every AURA timepiece is registered to our global horological registry. Comprehensive servicing, mechanical calibration, and water-resistance seal renewals are guaranteed every 24 months.',
      isFavorite: (json['is_favorite'] ?? json['isFavorite']) as bool? ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'price': price,
      'original_price': originalPrice,
      'rating': rating,
      'reviews_count': reviewsCount,
      'image_url': imageUrl,
      'stock_status': stockStatus,
      'material_summary': materialSummary,
      'calibre_description': calibreDescription,
      'movement': movement,
      'glass': glass,
      'strap_material': strapMaterial,
      'power_reserve': powerReserve,
      'delivery_description': deliveryDescription,
      'guarantee_description': guaranteeDescription,
      'is_favorite': isFavorite,
    };
  }
}
