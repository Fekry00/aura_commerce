import 'package:aura/core/routing/routes.dart';
import 'package:aura/core/theme/app_colors.dart';
import 'package:aura/core/theme/app_typography.dart';
import 'package:aura/core/utils/functions/custom_snack_bar.dart';
import 'package:aura/features/category/domain/entities/category_entity.dart';
import 'package:aura/features/category/presentation/widgets/category_subdepartments_sheet.dart';
import 'package:flutter/material.dart';

class CategoryCard extends StatefulWidget {
  const CategoryCard({
    super.key,
    required this.category,
    required this.onTap,
  });

  final CategoryEntity category;
  final VoidCallback onTap;

  @override
  State<CategoryCard> createState() => _CategoryCardState();
}

class _CategoryCardState extends State<CategoryCard>
    with SingleTickerProviderStateMixin {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    final category = widget.category;
    final subDepartments = category.subDepartments;

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: AppColors.outlineVariant.withValues(alpha: 0.5),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Column(
          children: [
            // Main Top Row
            GestureDetector(
              onTap: widget.onTap,
              behavior: HitTestBehavior.opaque,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Thumbnail
                    Container(
                      width: 80,
                      height: 96,
                      decoration: BoxDecoration(
                        color: AppColors.surfaceContainerLow,
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(
                          color: AppColors.outlineVariant.withValues(alpha: 0.3),
                        ),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(13),
                        child: category.image != null &&
                                category.image!.isNotEmpty
                            ? Image.network(
                                category.image!,
                                fit: BoxFit.cover,
                                errorBuilder: (_, _, _) =>
                                    _buildFallbackThumb(),
                              )
                            : _buildFallbackThumb(),
                      ),
                    ),
                    const SizedBox(width: 14),

                    // Content
                    Expanded(
                      child: SizedBox(
                        height: 96,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      (category.collectionLabel ??
                                              'COLLECTION')
                                          .toUpperCase(),
                                      style: AppTypography.labelSm.copyWith(
                                        color: AppColors.secondary,
                                        fontSize: 10,
                                        fontWeight: FontWeight.w700,
                                        letterSpacing: 1.2,
                                      ),
                                    ),
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 8,
                                        vertical: 3,
                                      ),
                                      decoration: BoxDecoration(
                                        color: const Color(0xFF6CF8BB)
                                            .withValues(alpha: 0.25),
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: Text(
                                        category.creationsCount ??
                                            (category.isActive
                                                ? 'ACTIVE'
                                                : 'ARCHIVED'),
                                        style: AppTypography.labelSm.copyWith(
                                          color: const Color(0xFF00714D),
                                          fontSize: 9,
                                          fontWeight: FontWeight.w700,
                                          letterSpacing: 0.5,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 3),
                                Text(
                                  category.name,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: AppTypography.headlineSm.copyWith(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700,
                                    color: AppColors.slateHeadline,
                                  ),
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  category.description ?? category.slug,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: AppTypography.bodySm.copyWith(
                                    fontSize: 12,
                                    color: AppColors.slateBody,
                                  ),
                                ),
                              ],
                            ),

                            // Sub-departments trigger button
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  _isExpanded = !_isExpanded;
                                });
                              },
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    'Sub-departments',
                                    style: AppTypography.labelSm.copyWith(
                                      color: const Color(0xFF0B3B2C),
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  const SizedBox(width: 4),
                                  AnimatedRotation(
                                    duration: const Duration(milliseconds: 200),
                                    turns: _isExpanded ? 0.5 : 0.0,
                                    child: const Icon(
                                      Icons.expand_more,
                                      size: 16,
                                      color: Color(0xFF0B3B2C),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Expandable Subcategories Tray
            AnimatedCrossFade(
              duration: const Duration(milliseconds: 250),
              crossFadeState: _isExpanded
                  ? CrossFadeState.showSecond
                  : CrossFadeState.showFirst,
              firstChild: const SizedBox(width: double.infinity, height: 0),
              secondChild: Container(
                width: double.infinity,
                padding: const EdgeInsets.fromLTRB(16, 8, 16, 14),
                decoration: BoxDecoration(
                  color: AppColors.surfaceContainerLow.withValues(alpha: 0.5),
                  border: Border(
                    top: BorderSide(
                      color: AppColors.outlineVariant.withValues(alpha: 0.3),
                    ),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: subDepartments.isNotEmpty
                          ? subDepartments.map((sub) {
                              return GestureDetector(
                                onTap: () {
                                  Navigator.pushNamed(
                                    context,
                                    Routes.categoryDetailsView,
                                    arguments: {
                                      'category': category,
                                      'subDepartment': sub.name,
                                    },
                                  );
                                },
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 12,
                                    vertical: 6,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(20),
                                    border: Border.all(
                                      color: AppColors.outlineVariant
                                          .withValues(alpha: 0.4),
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                        color:
                                            Colors.black.withValues(alpha: 0.02),
                                        blurRadius: 4,
                                        offset: const Offset(0, 1),
                                      ),
                                    ],
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        sub.name,
                                        style: AppTypography.bodySm.copyWith(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w500,
                                          color: AppColors.onSurface,
                                        ),
                                      ),
                                      if (sub.badge != null) ...[
                                        const SizedBox(width: 5),
                                        Container(
                                          width: 5,
                                          height: 5,
                                          decoration: const BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: AppColors.secondary,
                                          ),
                                        ),
                                      ],
                                    ],
                                  ),
                                ),
                              );
                            }).toList()
                          : [
                              _buildDefaultChip('All Items', context),
                              _buildDefaultChip('Vault Exclusives', context),
                              _buildDefaultChip('Signatures', context),
                            ],
                    ),
                    const SizedBox(height: 10),
                    Align(
                      alignment: Alignment.centerRight,
                      child: GestureDetector(
                        onTap: () {
                          CategorySubdepartmentsSheet.show(context, category);
                        },
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              'View Details Sheet',
                              style: AppTypography.labelSm.copyWith(
                                color: const Color(0xFF006C49),
                                fontSize: 11,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            const SizedBox(width: 3),
                            const Icon(
                              Icons.arrow_forward_ios_rounded,
                              size: 10,
                              color: Color(0xFF006C49),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDefaultChip(String title, BuildContext context) {
    return GestureDetector(
      onTap: () => showCustomSnackBar(
        context,
        message: 'Opening $title',
        type: SnackBarType.info,
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: AppColors.outlineVariant.withValues(alpha: 0.4),
          ),
        ),
        child: Text(
          title,
          style: AppTypography.bodySm.copyWith(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: AppColors.onSurface,
          ),
        ),
      ),
    );
  }

  Widget _buildFallbackThumb() {
    return Container(
      color: AppColors.surfaceContainerLow,
      child: const Center(
        child: Icon(
          Icons.category_outlined,
          color: Color(0xFF0B3B2C),
          size: 28,
        ),
      ),
    );
  }
}
