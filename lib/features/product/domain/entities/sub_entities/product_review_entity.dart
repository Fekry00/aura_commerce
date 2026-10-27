class ProductReviewEntity {
  const ProductReviewEntity({
    required this.id,
    required this.authorName,
    required this.authorInitials,
    required this.authorStatus,
    required this.rating,
    required this.comment,
    required this.purchaseInfo,
    this.authorAvatar,
  });

  final String id;
  final String authorName;
  final String authorInitials;
  final String authorStatus;
  final double rating;
  final String comment;
  final String purchaseInfo;
  final String? authorAvatar;
}
