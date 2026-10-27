import 'package:aura/core/routing/routes.dart';
import 'package:aura/core/theme/app_colors.dart';
import 'package:aura/core/theme/app_typography.dart';
import 'package:aura/core/widgets/shimmer/app_shimmer.dart';
import 'package:aura/features/category/domain/entities/category_entity.dart';
import 'package:aura/features/category/presentation/utils/category_ui_helper.dart';
import 'package:aura/features/category/presentation/widgets/category_subdepartments_sheet.dart';
import 'package:flutter/material.dart';

class CategoryCard extends StatefulWidget {
  const CategoryCard({
    super.key,
    required this.category,
    required this.onTap,
    this.onSubDepartmentTap,
    this.onViewDetailsSheetTap,
  });

  final CategoryEntity category;
  final VoidCallback onTap;
  final ValueChanged<SubDepartmentEntity>? onSubDepartmentTap;
  final VoidCallback? onViewDetailsSheetTap;

  @override
  State<CategoryCard> createState() => _CategoryCardState();
}

class _CategoryCardState extends State<CategoryCard>
    with SingleTickerProviderStateMixin {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    final category = widget.category;
    final subDepartments = CategoryUiHelper.getEffectiveSubDepartments(category);
    final coverImage = CategoryUiHelper.getCategoryCoverImage(category);

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: AppColors.outlineVariant.withValues(alpha: 0.45),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF002419).withValues(alpha: 0.04),
            blurRadius: 16,
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
                    // Thumbnail with real image & fallback icon from Home
                    Container(
                      width: 80,
                      height: 96,
                      decoration: BoxDecoration(
                        color: AppColors.surfaceContainerLow,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: AppColors.outlineVariant.withValues(alpha: 0.35),
                        ),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: (coverImage != null && coverImage.isNotEmpty)
                            ? Image.network(
                                coverImage,
                                fit: BoxFit.cover,
                                loadingBuilder:
                                    (context, child, loadingProgress) {
                                  if (loadingProgress == null) return child;
                                  return const ShimmerImageLoading();
                                },
                                errorBuilder: (context, error, stackTrace) =>
                                    _buildFallbackThumb(category),
                              )
                            : _buildFallbackThumb(category),
                      ),
                    ),
                    const SizedBox(width: 14),

                    // Content details
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
                                      (category.collectionLabel ?? 'COLLECTION')
                                          .toUpperCase(),
                                      style: AppTypography.labelSm.copyWith(
                                        color: const Color(0xFF006C49),
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
                                const SizedBox(height: 4),
                                Text(
                                  category.name,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: AppTypography.headlineSm.copyWith(
                                    fontSize: 17,
                                    fontWeight: FontWeight.w700,
                                    color: const Color(0xFF002419),
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
                                      color: const Color(0xFF1E382B),
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
                                      color: Color(0xFF1E382B),
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
                      children: subDepartments.map((sub) {
                        return GestureDetector(
                          onTap: () {
                            if (widget.onSubDepartmentTap != null) {
                              widget.onSubDepartmentTap!(sub);
                            } else {
                              Navigator.pushNamed(
                                context,
                                Routes.categoryDetailsView,
                                arguments: {
                                  'category': category,
                                  'subDepartment': sub.name,
                                },
                              );
                            }
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
                                  color: Colors.black.withValues(alpha: 0.02),
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
                                      color: Color(0xFF006C49),
                                    ),
                                  ),
                                ],
                              ],
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                    const SizedBox(height: 10),
                    Align(
                      alignment: Alignment.centerRight,
                      child: GestureDetector(
                        onTap: () {
                          if (widget.onViewDetailsSheetTap != null) {
                            widget.onViewDetailsSheetTap!();
                          } else {
                            CategorySubdepartmentsSheet.show(context, category);
                          }
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

  Widget _buildFallbackThumb(CategoryEntity cat) {
    final icon = CategoryUiHelper.getCategoryIcon(cat.name, cat.slug);
    return Container(
      color: const Color(0xFFE8F5E9),
      child: Center(
        child: Icon(
          icon,
          color: const Color(0xFF1E382B),
          size: 32,
        ),
      ),
    );
  }
}
