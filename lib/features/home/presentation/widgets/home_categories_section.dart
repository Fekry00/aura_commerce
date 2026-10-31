import 'package:aura/core/routing/routes.dart';
import 'package:aura/core/theme/app_colors.dart';
import 'package:aura/core/theme/app_typography.dart';
import 'package:aura/features/home/domain/entities/sub_entities/category_entity.dart';
import 'package:aura/features/home/presentation/utils/home_category_icon_helper.dart';
import 'package:aura/core/widgets/app_cached_image.dart';
import 'package:flutter/material.dart';

class HomeCategoriesSection extends StatelessWidget {
  final List<CategoryEntity>? categories;
  final int? selectedCategoryId;
  final ValueChanged<CategoryEntity?>? onCategorySelected;
  final VoidCallback? onViewAllTap;

  const HomeCategoriesSection({
    super.key,
    this.categories,
    this.selectedCategoryId,
    this.onCategorySelected,
    this.onViewAllTap,
  });

  static const List<Map<String, dynamic>> _fallbackCategories = [
    {'id': 1, 'name': 'Electronics', 'icon': Icons.devices_outlined},
    {'id': 2, 'name': 'Clothing', 'icon': Icons.checkroom_outlined},
    {'id': 3, 'name': 'Beauty', 'icon': Icons.spa_outlined},
  ];

  @override
  Widget build(BuildContext context) {
    final hasRemote = categories != null && categories!.isNotEmpty;
    final count = hasRemote ? categories!.length : _fallbackCategories.length;

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Categories',
              style: AppTypography.headlineSm.copyWith(
                fontWeight: FontWeight.w700,
                fontSize: 18,
              ),
            ),
            GestureDetector(
              onTap: () {
                if (onViewAllTap != null) {
                  onViewAllTap!.call();
                } else {
                  Navigator.pushNamed(context, Routes.categoriesView);
                }
              },
              child: Text(
                'View All',
                style: AppTypography.labelSm.copyWith(
                  color: const Color(0xFF1E382B),
                  fontWeight: FontWeight.w700,
                  fontSize: 13,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.spaceMd),
        SizedBox(
          height: 94,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            itemCount: count,
            separatorBuilder: (context, index) =>
                const SizedBox(width: AppSpacing.spaceMd),
            itemBuilder: (context, index) {
              final String name;
              final String? imageUrl;
              final IconData icon;
              final int catId;

              if (hasRemote) {
                final cat = categories![index];
                name = cat.name;
                imageUrl = (cat.image != null && cat.image!.trim().isNotEmpty)
                    ? cat.image!.trim()
                    : null;
                icon = HomeCategoryIconHelper.getCategoryIcon(cat.name, cat.slug);
                catId = cat.id;
              } else {
                final fallback = _fallbackCategories[index];
                name = fallback['name'] as String;
                imageUrl = null;
                icon = fallback['icon'] as IconData;
                catId = fallback['id'] as int;
              }

              final isSelected = selectedCategoryId == catId;

              return GestureDetector(
                onTap: () {
                  if (hasRemote) {
                    final cat = categories![index];
                    if (isSelected) {
                      onCategorySelected?.call(null);
                    } else {
                      onCategorySelected?.call(cat);
                    }
                  } else {
                    if (isSelected) {
                      onCategorySelected?.call(null);
                    } else {
                      onCategorySelected?.call(
                        CategoryEntity(
                          id: catId,
                          name: name,
                          slug: name.toLowerCase(),
                        ),
                      );
                    }
                  }
                },
                child: Column(
                  children: [
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 250),
                      width: 58,
                      height: 58,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: isSelected
                            ? const Color(0xFF1E382B)
                            : Colors.white,
                        border: Border.all(
                          color: isSelected
                              ? Colors.transparent
                              : const Color(0xFFE2E8F0),
                          width: 1,
                        ),
                        boxShadow: isSelected
                            ? [
                                BoxShadow(
                                  color: const Color(0xFF1E382B)
                                      .withValues(alpha: 0.2),
                                  blurRadius: 8,
                                  offset: const Offset(0, 4),
                                ),
                              ]
                            : null,
                      ),
                      child: ClipOval(
                        child: (imageUrl != null && imageUrl.isNotEmpty)
                            ? AppCachedImage(
                                imageUrl: imageUrl,
                                fit: BoxFit.cover,
                                placeholder: Container(
                                  color: isSelected
                                      ? const Color(0xFF1E382B)
                                      : const Color(0xFFF1F5F9),
                                  child: Icon(
                                    icon,
                                    color: isSelected
                                        ? Colors.white
                                        : AppColors.slateHeadline,
                                    size: 22,
                                  ),
                                ),
                                errorWidget: Icon(
                                  icon,
                                  color: isSelected
                                      ? Colors.white
                                      : AppColors.slateHeadline,
                                  size: 22,
                                ),
                              )
                            : Icon(
                                icon,
                                color: isSelected
                                    ? Colors.white
                                    : AppColors.slateHeadline,
                                size: 22,
                              ),
                      ),
                    ),
                    const SizedBox(height: AppSpacing.spaceSm),
                    SizedBox(
                      width: 72,
                      child: Text(
                        name,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.center,
                        style: AppTypography.bodySm.copyWith(
                          color: isSelected
                              ? const Color(0xFF1E382B)
                              : AppColors.slateBody,
                          fontWeight:
                              isSelected ? FontWeight.w700 : FontWeight.w500,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}