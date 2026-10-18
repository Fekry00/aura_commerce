class ProductRatingEntity {
  const ProductRatingEntity({
    required this.average,
    required this.reviewsCount,
  });

  final double average;
  final int reviewsCount;
}