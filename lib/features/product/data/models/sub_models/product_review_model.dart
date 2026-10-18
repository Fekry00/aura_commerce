import 'package:aura/features/product/domain/entities/sub_entities/product_review_entity.dart';

class ProductReviewModel extends ProductReviewEntity {
  const ProductReviewModel({
    required super.id,
    required super.authorName,
    required super.authorInitials,
    required super.authorStatus,
    required super.rating,
    required super.comment,
    required super.purchaseInfo,
  });

  factory ProductReviewModel.fromJson(Map<String, dynamic> json) {
    return ProductReviewModel(
      id: json['id']?.toString() ?? '',
      authorName: (json['author_name'] ?? json['authorName']) as String? ??
          'Julian L.',
      authorInitials: (json['author_initials'] ?? json['authorInitials'])
              as String? ??
          'JL',
      authorStatus: (json['author_status'] ?? json['authorStatus'])
              as String? ??
          'Verified Atelier Owner',
      rating: (json['rating'] as num?)?.toDouble() ?? 5.0,
      comment: json['comment'] as String? ??
          '"The brushed titanium finish absorbs light unlike anything else in my collection. Weighs next to nothing on the wrist, yet feels indestructible. Outstanding design restraint."',
      purchaseInfo: (json['purchase_info'] ?? json['purchaseInfo'])
              as String? ??
          'Purchased: 40mm / Brushed Titanium • 2 weeks ago',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'author_name': authorName,
      'author_initials': authorInitials,
      'author_status': authorStatus,
      'rating': rating,
      'comment': comment,
      'purchase_info': purchaseInfo,
    };
  }
}
