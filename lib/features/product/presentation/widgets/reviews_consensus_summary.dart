import 'package:aura/core/theme/app_colors.dart';
import 'package:aura/core/theme/app_typography.dart';
import 'package:flutter/material.dart';


class ReviewsConsensusSummary extends StatelessWidget {
  const ReviewsConsensusSummary({super.key});

  @override
  Widget build(BuildContext context) {
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
                style: AppTypography.labelCaps.copyWith(color: AppColors.slateBody, fontSize: 10),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: const Color(0xFFE8F5E9),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.check_circle_rounded, color: Color(0xFF2E7D32), size: 12),
                    const SizedBox(width: 4),
                    Text(
                      '98% Recommended',
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
            style: AppTypography.headlineSm.copyWith(fontWeight: FontWeight.w800, fontSize: 16),
          ),
          const SizedBox(height: AppSpacing.spaceMd),

          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '4.9',
                    style: AppTypography.headlineLg.copyWith(fontSize: 42, fontWeight: FontWeight.w900),
                  ),
                  Row(
                    children: List.generate(
                      5,
                      (index) => const Icon(Icons.star_rounded, color: Colors.amber, size: 16),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '128 Total Reviews',
                    style: AppTypography.bodySm.copyWith(color: AppColors.slateBody, fontSize: 11),
                  ),
                ],
              ),
              const SizedBox(width: AppSpacing.spaceLg),
              Expanded(
                child: Column(
                  children: const [
                    _RatingBarRow(stars: '5', count: '110', fillRatio: 0.85),
                    _RatingBarRow(stars: '4', count: '13', fillRatio: 0.12),
                    _RatingBarRow(stars: '3', count: '3', fillRatio: 0.03),
                    _RatingBarRow(stars: '2', count: '1', fillRatio: 0.01),
                    _RatingBarRow(stars: '1', count: '1', fillRatio: 0.01),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: AppSpacing.spaceMd),
          const Divider(thickness: 0.5),
          const SizedBox(height: AppSpacing.spaceSm),

          Row(
            children: const [
              Expanded(child: _CriteriaBox(title: 'Luminescence', score: '5.0 / 5.0')),
              SizedBox(width: AppSpacing.spaceSm),
              Expanded(child: _CriteriaBox(title: 'Absorption', score: '4.9 / 5.0')),
              SizedBox(width: AppSpacing.spaceSm),
              Expanded(child: _CriteriaBox(title: 'Flacon Finish', score: '5.0 / 5.0')),
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
          Text(stars, style: AppTypography.bodySm.copyWith(fontSize: 10, color: AppColors.slateBody)),
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
              style: AppTypography.bodySm.copyWith(fontSize: 10, color: AppColors.slateBody),
              textAlign: TextAlign.end,
            ),
          ),
        ],
      ),
    );
  }
}

class _CriteriaBox extends StatelessWidget {
  final String title;
  final String score;

  const _CriteriaBox({required this.title, required this.score});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 6),
      decoration: BoxDecoration(
        color: const Color(0xFFF8F9FA),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          Text(title, style: AppTypography.bodySm.copyWith(color: AppColors.slateBody, fontSize: 10)),
          const SizedBox(height: 2),
          Text(score, style: AppTypography.bodySm.copyWith(fontWeight: FontWeight.w700, fontSize: 11)),
        ],
      ),
    );
  }
}