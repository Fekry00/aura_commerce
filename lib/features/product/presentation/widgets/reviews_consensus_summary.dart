import 'package:aura/core/theme/app_colors.dart';
import 'package:aura/core/theme/app_typography.dart';
import 'package:aura/features/product/domain/entities/sub_entities/product_review_entity.dart';
import 'package:aura/features/product/domain/entities/sub_entities/review_consensus_data.dart';
import 'package:flutter/material.dart';

class ReviewsConsensusSummary extends StatelessWidget {
  final ReviewConsensusData consensusData;

  const ReviewsConsensusSummary({
    super.key,
    required this.consensusData,
  });

  factory ReviewsConsensusSummary.fromReviews({
    Key? key,
    List<ProductReviewEntity>? reviews,
  }) {
    return ReviewsConsensusSummary(
      key: key,
      consensusData: ReviewConsensusData.fromReviews(reviews),
    );
  }

  @override
  Widget build(BuildContext context) {
    final count = consensusData.totalCount;
    final avgRating = consensusData.avgRating;
    final recommendedPct = consensusData.recommendedPercentage;

    return Container(
      padding: const EdgeInsets.all(AppSpacing.spaceMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE9ECEF)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'COLLECTOR CONSENSUS',
                style: AppTypography.labelCaps.copyWith(
                  color: AppColors.slateBody,
                  fontSize: 10,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: const Color(0xFFE8F5E9),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    const Icon(
                      Icons.check_circle_rounded,
                      color: Color(0xFF2E7D32),
                      size: 12,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      '$recommendedPct% Recommended',
                      style: AppTypography.labelCaps.copyWith(
                        color: const Color(0xFF2E7D32),
                        fontWeight: FontWeight.w700,
                        fontSize: 10,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            'Overall Satisfaction',
            style: AppTypography.headlineSm.copyWith(
              fontWeight: FontWeight.w800,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: AppSpacing.spaceMd),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    avgRating.toStringAsFixed(1),
                    style: AppTypography.headlineLg.copyWith(
                      fontSize: 42,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  Row(
                    children: List.generate(
                      5,
                      (index) => Icon(
                        index < avgRating.round()
                            ? Icons.star_rounded
                            : Icons.star_outline_rounded,
                        color: Colors.amber,
                        size: 16,
                      ),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '$count Total Review${count == 1 ? '' : 's'}',
                    style: AppTypography.bodySm.copyWith(
                      color: AppColors.slateBody,
                      fontSize: 11,
                    ),
                  ),
                ],
              ),
              const SizedBox(width: AppSpacing.spaceLg),
              Expanded(
                child: Column(
                  children: [
                    _RatingBarRow(
                      stars: '5',
                      count: '${consensusData.stars5Count}',
                      fillRatio: consensusData.ratio5,
                    ),
                    _RatingBarRow(
                      stars: '4',
                      count: '${consensusData.stars4Count}',
                      fillRatio: consensusData.ratio4,
                    ),
                    _RatingBarRow(
                      stars: '3',
                      count: '${consensusData.stars3Count}',
                      fillRatio: consensusData.ratio3,
                    ),
                    _RatingBarRow(
                      stars: '2',
                      count: '${consensusData.stars2Count}',
                      fillRatio: consensusData.ratio2,
                    ),
                    _RatingBarRow(
                      stars: '1',
                      count: '${consensusData.stars1Count}',
                      fillRatio: consensusData.ratio1,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _RatingBarRow extends StatelessWidget {
  final String stars;
  final String count;
  final double fillRatio;

  const _RatingBarRow({
    required this.stars,
    required this.count,
    required this.fillRatio,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2.0),
      child: Row(
        children: [
          Text(
            stars,
            style: AppTypography.bodySm.copyWith(
              fontSize: 10,
              color: AppColors.slateBody,
            ),
          ),
          const SizedBox(width: 6),
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: LinearProgressIndicator(
                value: fillRatio,
                backgroundColor: const Color(0xFFEDF2F7),
                color: const Color(0xFF1E382B),
                minHeight: 6,
              ),
            ),
          ),
          const SizedBox(width: 8),
          SizedBox(
            width: 24,
            child: Text(
              count,
              style: AppTypography.bodySm.copyWith(
                fontSize: 10,
                color: AppColors.slateBody,
              ),
              textAlign: TextAlign.end,
            ),
          ),
        ],
      ),
    );
  }
}