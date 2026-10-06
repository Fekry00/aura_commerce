import 'package:aura/core/theme/app_colors.dart';
import 'package:aura/core/theme/app_typography.dart';
import 'package:aura/core/utils/functions/custom_snack_bar.dart';
import 'package:flutter/material.dart';


class ReviewsListSection extends StatefulWidget {
  const ReviewsListSection({super.key});

  @override
  State<ReviewsListSection> createState() => _ReviewsListSectionState();
}

class _ReviewsListSectionState extends State<ReviewsListSection> {
  int _selectedFilter = 0;
  final List<String> _filters = ['All (128)', '★ 5 Stars (110)', '★ 4 Stars (13)', 'With Notes (8)'];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Curated Reviews (128)',
              style: AppTypography.bodySm.copyWith(fontWeight: FontWeight.w700, fontSize: 13),
            ),
            Row(
              children: [
                Text('Most Recent', style: AppTypography.bodySm.copyWith(fontSize: 11, color: AppColors.slateBody)),
                const Icon(Icons.keyboard_arrow_down_rounded, size: 16, color: AppColors.slateBody),
              ],
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.spaceSm),

         SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          physics: const BouncingScrollPhysics(),
          child: Row(
            children: List.generate(_filters.length, (index) {
              final isSelected = _selectedFilter == index;
              return GestureDetector(
                onTap: () => setState(() => _selectedFilter = index),
                child: Container(
                  margin: const EdgeInsets.only(right: 8),
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: isSelected ? const Color(0xFF1E382B) : const Color(0xFFF1F3F5),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Text(
                    _filters[index],
                    style: AppTypography.labelSm.copyWith(
                      color: isSelected ? Colors.white : AppColors.slateHeadline,
                      fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                      fontSize: 11,
                    ),
                  ),
                ),
              );
            }),
          ),
        ),
        const SizedBox(height: AppSpacing.spaceMd),

         _buildUserReviewCard(context),
        const SizedBox(height: AppSpacing.spaceSm + 2),

         _buildStandardReviewCard(
          initials: 'SD',
          name: 'Sophia Daniels',
          badge: 'VIP Luminary',
          date: '2 days ago',
          content: 'Unrivaled skin tone radiance. After two weeks of evening application, pigmentation softened noticeably. The amber flacon preserves potency with true artisan caliber.',
        ),
      ],
    );
  }

  Widget _buildUserReviewCard(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.spaceMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFF2E7D32).withOpacity(0.4)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const CircleAvatar(
                radius: 16,
                backgroundColor: Color(0xFFE0F2FE),
                child: Text('AM', style: TextStyle(color: Color(0xFF0369A1), fontSize: 11, fontWeight: FontWeight.bold)),
              ),
              const SizedBox(width: AppSpacing.spaceSm),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text('Ahmed Mohamed', style: AppTypography.bodySm.copyWith(fontWeight: FontWeight.w700)),
                      const SizedBox(width: 4),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 1),
                        decoration: BoxDecoration(
                          color: const Color(0xFFF1F5F9),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text('You', style: AppTypography.labelCaps.copyWith(fontSize: 9, color: AppColors.slateBody)),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      ...List.generate(5, (_) => const Icon(Icons.star_rounded, color: Colors.amber, size: 14)),
                      const SizedBox(width: 4),
                      Text('Today', style: AppTypography.bodySm.copyWith(color: AppColors.slateBody, fontSize: 10)),
                    ],
                  ),
                ],
              ),
              const Spacer(),
              Row(
                children: [
                  Container(
                    width: 6,
                    height: 6,
                    decoration: const BoxDecoration(color: Color(0xFF2E7D32), shape: BoxShape.circle),
                  ),
                  const SizedBox(width: 4),
                  Text(
                    'YOUR REVIEW • PUBLISHED',
                    style: AppTypography.labelCaps.copyWith(
                      color: const Color(0xFF2E7D32),
                      fontSize: 9,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.spaceSm),
          Text(
            'Great product! Exceptional texture, absorbed immediately with zero residue. The armored concierge delivery to Mansoura was impeccably punctual and flawless.',
            style: AppTypography.bodySm.copyWith(fontSize: 12, height: 1.4),
          ),
          const SizedBox(height: AppSpacing.spaceSm),
          Row(
            children: [
              const Icon(Icons.verified_outlined, color: Color(0xFF2E7D32), size: 14),
              const SizedBox(width: 4),
              Text(
                'Verified Acquisition #AL-984218',
                style: AppTypography.labelSm.copyWith(color: const Color(0xFF2E7D32), fontSize: 10),
              ),
              const Spacer(),
              InkWell(
                onTap: () => showCustomSnackBar(context, message: 'Editing review...', type: SnackBarType.info),
                child: Row(
                  children: [
                    const Icon(Icons.edit_outlined, size: 12, color: AppColors.slateBody),
                    const SizedBox(width: 2),
                    Text('Edit', style: AppTypography.bodySm.copyWith(fontSize: 11, color: AppColors.slateBody)),
                  ],
                ),
              ),
              const SizedBox(width: AppSpacing.spaceSm),
              InkWell(
                onTap: () => showCustomSnackBar(context, message: 'Review deleted', type: SnackBarType.error),
                child: Row(
                  children: [
                    const Icon(Icons.delete_outline, size: 12, color: Color(0xFFDC2626)),
                    const SizedBox(width: 2),
                    Text('Delete', style: AppTypography.bodySm.copyWith(fontSize: 11, color: const Color(0xFFDC2626))),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStandardReviewCard({
    required String initials,
    required String name,
    required String badge,
    required String date,
    required String content,
  }) {
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
            children: [
              CircleAvatar(
                radius: 16,
                backgroundColor: const Color(0xFFFEF3C7),
                child: Text(initials, style: const TextStyle(color: Color(0xFFB45309), fontSize: 11, fontWeight: FontWeight.bold)),
              ),
              const SizedBox(width: AppSpacing.spaceSm),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(name, style: AppTypography.bodySm.copyWith(fontWeight: FontWeight.w700)),
                      const SizedBox(width: 4),
                      const Icon(Icons.verified_rounded, color: Color(0xFF1E382B), size: 12),
                    ],
                  ),
                  Text('$badge • $date', style: AppTypography.bodySm.copyWith(color: AppColors.slateBody, fontSize: 10)),
                ],
              ),
              const Spacer(),
              Row(
                children: List.generate(5, (_) => const Icon(Icons.star_rounded, color: Colors.amber, size: 14)),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.spaceSm),
          Text(content, style: AppTypography.bodySm.copyWith(fontSize: 12, height: 1.4)),
        ],
      ),
    );
  }
}