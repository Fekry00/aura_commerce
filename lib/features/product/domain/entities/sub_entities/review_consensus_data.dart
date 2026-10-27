import 'package:aura/features/product/domain/entities/sub_entities/product_review_entity.dart';

class ReviewConsensusData {
  final double avgRating;
  final int totalCount;
  final int recommendedPercentage;
  final int stars5Count;
  final int stars4Count;
  final int stars3Count;
  final int stars2Count;
  final int stars1Count;
  final double ratio5;
  final double ratio4;
  final double ratio3;
  final double ratio2;
  final double ratio1;

  const ReviewConsensusData({
    required this.avgRating,
    required this.totalCount,
    required this.recommendedPercentage,
    required this.stars5Count,
    required this.stars4Count,
    required this.stars3Count,
    required this.stars2Count,
    required this.stars1Count,
    required this.ratio5,
    required this.ratio4,
    required this.ratio3,
    required this.ratio2,
    required this.ratio1,
  });

  factory ReviewConsensusData.fromReviews(List<ProductReviewEntity>? reviews) {
    final list = reviews ?? [];
    final count = list.length;
    final avg = count > 0
        ? list.fold<double>(0.0, (acc, r) => acc + r.rating) / count
        : 5.0;

    int s5 = 0;
    int s4 = 0;
    int s3 = 0;
    int s2 = 0;
    int s1 = 0;

    for (final r in list) {
      final rInt = r.rating.round();
      if (rInt >= 5) {
        s5++;
      } else if (rInt == 4) {
        s4++;
      } else if (rInt == 3) {
        s3++;
      } else if (rInt == 2) {
        s2++;
      } else {
        s1++;
      }
    }

    final r5 = count > 0 ? s5 / count : 1.0;
    final r4 = count > 0 ? s4 / count : 0.0;
    final r3 = count > 0 ? s3 / count : 0.0;
    final r2 = count > 0 ? s2 / count : 0.0;
    final r1 = count > 0 ? s1 / count : 0.0;

    final recPct =
        count > 0 ? (((s5 + s4) / count) * 100).round() : 100;

    return ReviewConsensusData(
      avgRating: avg,
      totalCount: count,
      recommendedPercentage: recPct,
      stars5Count: s5,
      stars4Count: s4,
      stars3Count: s3,
      stars2Count: s2,
      stars1Count: s1,
      ratio5: r5,
      ratio4: r4,
      ratio3: r3,
      ratio2: r2,
      ratio1: r1,
    );
  }
}
