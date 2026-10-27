import 'package:aura/core/routing/routes.dart';
import 'package:aura/core/theme/app_colors.dart';
import 'package:aura/core/theme/app_typography.dart';
import 'package:aura/features/product/domain/entities/sub_entities/product_item_entity.dart';
import 'package:aura/features/product/domain/entities/sub_entities/product_review_entity.dart';
import 'package:aura/features/product/presentation/widgets/reviewer_avatar.dart';
import 'package:flutter/material.dart';

class ProductSpecificationsCard extends StatelessWidget {
  final List<ProductReviewEntity>? reviews;
  final ProductItemEntity? product;
  final VoidCallback? onSeeAllReviewsTap;

  const ProductSpecificationsCard({
    super.key,
    this.reviews,
    this.product,
    this.onSeeAllReviewsTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(AppSpacing.spaceMd),
          decoration: BoxDecoration(
            color: const Color(0xFFF8F9FA),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: const Color(0xFFE9ECEF)),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Icon(
                Icons.shield_outlined,
                color: Color(0xFF1E382B),
                size: 18,
              ),
              const SizedBox(width: AppSpacing.spaceSm),
              Expanded(
                child: Text(
                  'Machined from monolithic 316L cold-forged stainless steel with dual-domed anti-reflective sapphire crystal, engineered to 5 ATM water resistance.',
                  style: AppTypography.bodySm.copyWith(
                    color: AppColors.slateBody,
                    fontSize: 12,
                    height: 1.4,
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: AppSpacing.spaceMd),

        // Accordion 1: Craftsmanship & Calibre
        _buildAccordion(
          title: 'Craftsmanship & Calibre',
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'The Aethel Minimalist Chronograph reconciles classic horology with brutalist purity. Featuring custom counterpoised sub-dials and a high-beat automatic movement tuned to +/- 3 seconds daily variance.',
                style: AppTypography.bodySm.copyWith(
                  color: AppColors.slateBody,
                  fontSize: 12,
                  height: 1.4,
                ),
              ),
              const SizedBox(height: AppSpacing.spaceMd),
              const Row(
                children: [
                  Expanded(
                    child: _SpecCard(
                      title: 'MOVEMENT',
                      value: 'Calibre AT-902 Autowind',
                    ),
                  ),
                  SizedBox(width: AppSpacing.spaceSm),
                  Expanded(
                    child: _SpecCard(
                      title: 'GLASS',
                      value: '9H Sapphire Crystal',
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.spaceSm),
              const Row(
                children: [
                  Expanded(
                    child: _SpecCard(
                      title: 'STRAP MATERIAL',
                      value: 'Full-grain Horween Leather',
                    ),
                  ),
                  SizedBox(width: AppSpacing.spaceSm),
                  Expanded(
                    child: _SpecCard(
                      title: 'POWER RESERVE',
                      value: '44-Hour Reserve',
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: AppSpacing.spaceSm),

        // Accordion 2: Complimentary Delivery & Concierge Returns
        _buildAccordion(
          title: 'Complimentary Delivery & Concierge Returns',
          content: Column(
            children: [
              _buildFeatureRow(
                icon: Icons.flight_takeoff_rounded,
                text:
                    'Dispatched via secure armored courier within 24 hours. Transit time 2-3 business days worldwide with door-to-door full valuation insurance.',
              ),
              const SizedBox(height: AppSpacing.spaceSm),
              _buildFeatureRow(
                icon: Icons.published_with_changes_rounded,
                text:
                    '30-day touch-and-feel window. Returns arranged at your residence at no cost with original seals intact.',
              ),
            ],
          ),
        ),
        const SizedBox(height: AppSpacing.spaceSm),

        // Accordion 3: Atelier 5-Year Guarantee
        _buildAccordion(
          title: 'Atelier 5-Year Guarantee',
          content: Text(
            'Every AURA timepiece is registered to our global horological registry. Comprehensive servicing, mechanical calibration, and water-resistance seal renewals are guaranteed every 24 months.',
            style: AppTypography.bodySm.copyWith(
              color: AppColors.slateBody,
              fontSize: 12,
              height: 1.4,
            ),
          ),
        ),
        const SizedBox(height: AppSpacing.spaceLg),

        // Section: Collector Perspective (Reviews)
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Collector Perspective',
              style: AppTypography.headlineSm.copyWith(
                fontSize: 15,
                fontWeight: FontWeight.w700,
              ),
            ),
            GestureDetector(
              onTap: () {
                if (onSeeAllReviewsTap != null) {
                  onSeeAllReviewsTap!();
                } else if (product != null) {
                  Navigator.pushNamed(
                    context,
                    Routes.productReviewsView,
                    arguments: product!,
                  );
                }
              },
              child: Text(
                reviews != null && reviews!.isNotEmpty
                    ? 'See all (${reviews!.length})'
                    : 'See all',
                style: AppTypography.labelSm.copyWith(
                  color: const Color(0xFF1E382B),
                  fontWeight: FontWeight.w700,
                  fontSize: 12,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.spaceSm),

        // Review Card
        if (reviews != null && reviews!.isNotEmpty) ...[
          Builder(
            builder: (context) {
              final review = reviews!.first;
              return Container(
                padding: const EdgeInsets.all(AppSpacing.spaceMd),
                decoration: BoxDecoration(
                  color: const Color(0xFFF8F9FA),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: const Color(0xFFE9ECEF)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        ReviewerAvatar(review: review, radius: 16),
                        const SizedBox(width: AppSpacing.spaceSm),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                review.authorName,
                                style: AppTypography.bodySm.copyWith(
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              Text(
                                review.authorStatus,
                                style: AppTypography.bodySm.copyWith(
                                  color: AppColors.slateBody,
                                  fontSize: 10,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Row(
                          children: List.generate(
                            review.rating.clamp(1, 5).toInt(),
                            (index) => const Icon(
                              Icons.star_rounded,
                              color: Color(0xFF1E382B),
                              size: 16,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: AppSpacing.spaceSm),
                    Text(
                      '"${review.comment}"',
                      style: AppTypography.bodySm.copyWith(
                        fontStyle: FontStyle.italic,
                        height: 1.4,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.spaceXs),
                    Text(
                      review.purchaseInfo,
                      style: AppTypography.bodySm.copyWith(
                        color: AppColors.slateBody,
                        fontSize: 11,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ] else ...[
          Container(
            padding: const EdgeInsets.all(AppSpacing.spaceMd),
            decoration: BoxDecoration(
              color: const Color(0xFFF8F9FA),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: const Color(0xFFE9ECEF)),
            ),
            child: Column(
              children: [
                const Icon(
                  Icons.rate_review_outlined,
                  size: 28,
                  color: Color(0xFF1E382B),
                ),
                const SizedBox(height: 8),
                Text(
                  'No reviews yet for this product.',
                  style: AppTypography.bodySm.copyWith(
                    fontWeight: FontWeight.w600,
                    color: AppColors.slateBody,
                    fontSize: 12,
                  ),
                ),
                const SizedBox(height: 6),
                TextButton(
                  onPressed: () {
                    if (onSeeAllReviewsTap != null) {
                      onSeeAllReviewsTap!();
                    } else if (product != null) {
                      Navigator.pushNamed(
                        context,
                        Routes.productReviewsView,
                        arguments: product!,
                      );
                    }
                  },
                  child: const Text(
                    'Be the first to review',
                    style: TextStyle(
                      color: Color(0xFF1E382B),
                      fontWeight: FontWeight.w700,
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],

        const SizedBox(height: AppSpacing.spaceSm),

        // Packaging Note
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.spaceMd,
            vertical: AppSpacing.spaceSm,
          ),
          decoration: BoxDecoration(
            color: const Color(0xFFF8F9FA),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              const Icon(
                Icons.eco_outlined,
                color: Color(0xFF1E382B),
                size: 16,
              ),
              const SizedBox(width: AppSpacing.spaceSm),
              Expanded(
                child: Text(
                  'Carbon-neutral fabrication and sustainable recycled packaging.',
                  style: AppTypography.bodySm.copyWith(
                    color: AppColors.slateBody,
                    fontSize: 11,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  static Widget _buildAccordion({
    required String title,
    required Widget content,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE9ECEF)),
      ),
      child: Theme(
        data: ThemeData().copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          initiallyExpanded: true,
          iconColor: AppColors.onSurface,
          collapsedIconColor: AppColors.onSurface,
          title: Text(
            title,
            style: AppTypography.bodyLg.copyWith(
              fontWeight: FontWeight.w700,
              fontSize: 14,
            ),
          ),
          childrenPadding: const EdgeInsets.fromLTRB(
            AppSpacing.spaceMd,
            0,
            AppSpacing.spaceMd,
            AppSpacing.spaceMd,
          ),
          children: [content],
        ),
      ),
    );
  }

  static Widget _buildFeatureRow({
    required IconData icon,
    required String text,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, color: const Color(0xFF1E382B), size: 18),
        const SizedBox(width: AppSpacing.spaceSm),
        Expanded(
          child: Text(
            text,
            style: AppTypography.bodySm.copyWith(
              color: AppColors.slateBody,
              fontSize: 12,
              height: 1.35,
            ),
          ),
        ),
      ],
    );
  }
}

class _SpecCard extends StatelessWidget {
  final String title;
  final String value;

  const _SpecCard({required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.spaceSm + 2),
      decoration: BoxDecoration(
        color: const Color(0xFFF8F9FA),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: AppTypography.labelCaps.copyWith(
              color: AppColors.slateBody,
              fontSize: 9,
            ),
          ),
          const SizedBox(height: 3),
          Text(
            value,
            style: AppTypography.bodySm.copyWith(
              fontWeight: FontWeight.w600,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}
