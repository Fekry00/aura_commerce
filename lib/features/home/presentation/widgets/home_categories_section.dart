import 'package:aura/core/di/injection_container.dart';
import 'package:aura/core/routing/main_tab_controller.dart';
import 'package:aura/core/routing/routes.dart';
import 'package:aura/core/theme/app_colors.dart';
import 'package:aura/core/theme/app_typography.dart';
import 'package:aura/features/category/domain/entities/category_entity.dart';
import 'package:aura/features/category/presentation/cubit/category_cubit.dart';
import 'package:aura/features/category/presentation/cubit/category_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeCategoriesSection extends StatelessWidget {
  const HomeCategoriesSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<CategoryCubit>()..getCategories(),
      child: const _HomeCategoriesSectionContent(),
    );
  }
}

class _HomeCategoriesSectionContent extends StatefulWidget {
  const _HomeCategoriesSectionContent();

  @override
  State<_HomeCategoriesSectionContent> createState() =>
      _HomeCategoriesSectionContentState();
}

class _HomeCategoriesSectionContentState
    extends State<_HomeCategoriesSectionContent> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
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
                MainTabController.switchTab(1);
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

        BlocBuilder<CategoryCubit, CategoryState>(
          builder: (context, state) {
            if (state is GetCategoriesLoadingState) {
              return _buildHorizontalShimmer();
            }

            List<CategoryEntity> categories = [];
            if (state is GetCategoriesSuccessState) {
              categories = state.categories;
            }

            if (categories.isEmpty) {
              categories = _fallbackCategories;
            }

            return SizedBox(
              height: 96,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                physics: const BouncingScrollPhysics(),
                itemCount: categories.length,
                separatorBuilder: (context, index) =>
                    const SizedBox(width: AppSpacing.spaceMd),
                itemBuilder: (context, index) {
                  final item = categories[index];
                  final isSelected = _selectedIndex == index;

                  return GestureDetector(
                    onTap: () {
                      setState(() => _selectedIndex = index);
                      Navigator.pushNamed(
                        context,
                        Routes.categoryDetailsView,
                        arguments: item,
                      );
                    },
                    child: Column(
                      children: [
                        AnimatedContainer(
                          duration: const Duration(milliseconds: 250),
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: isSelected
                                ? const Color(0xFF1E382B)
                                : Colors.white,
                            border: Border.all(
                              color: isSelected
                                  ? Colors.transparent
                                  : const Color(0xFFE2E8F0),
                              width: 1.5,
                            ),
                            boxShadow: isSelected
                                ? [
                                    BoxShadow(
                                      color: const Color(0xFF1E382B)
                                          .withValues(alpha: 0.25),
                                      blurRadius: 8,
                                      offset: const Offset(0, 4),
                                    )
                                  ]
                                : [
                                    BoxShadow(
                                      color: Colors.black.withValues(alpha: 0.03),
                                      blurRadius: 4,
                                      offset: const Offset(0, 2),
                                    )
                                  ],
                          ),
                          child: ClipOval(
                            child: item.image != null && item.image!.isNotEmpty
                                ? Image.network(
                                    item.image!,
                                    fit: BoxFit.cover,
                                    errorBuilder: (_, _, _) =>
                                        _buildCategoryIcon(isSelected),
                                  )
                                : _buildCategoryIcon(isSelected),
                          ),
                        ),
                        const SizedBox(height: 6),
                        SizedBox(
                          width: 68,
                          child: Text(
                            item.name,
                            textAlign: TextAlign.center,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: AppTypography.bodySm.copyWith(
                              color: isSelected
                                  ? const Color(0xFF1E382B)
                                  : AppColors.slateBody,
                              fontWeight: isSelected
                                  ? FontWeight.w700
                                  : FontWeight.w500,
                              fontSize: 11,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _buildCategoryIcon(bool isSelected) {
    return Icon(
      Icons.category_outlined,
      color: isSelected ? Colors.white : AppColors.slateHeadline,
      size: 22,
    );
  }

  Widget _buildHorizontalShimmer() {
    return SizedBox(
      height: 96,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: 5,
        separatorBuilder: (_, _) => const SizedBox(width: AppSpacing.spaceMd),
        itemBuilder: (_, _) => Column(
          children: [
            Container(
              width: 60,
              height: 60,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.surfaceContainerLow,
              ),
            ),
            const SizedBox(height: 6),
            Container(
              width: 50,
              height: 10,
              decoration: BoxDecoration(
                color: AppColors.surfaceContainerLow,
                borderRadius: BorderRadius.circular(4),
              ),
            ),
          ],
        ),
      ),
    );
  }

  static const List<CategoryEntity> _fallbackCategories = [
    CategoryEntity(
      id: 1,
      name: 'Skin Care',
      slug: 'skin-care',
      description: 'Beauty and skin care',
      isActive: true,
    ),
    CategoryEntity(
      id: 2,
      name: 'Timepieces',
      slug: 'timepieces',
      description: 'Luxury horology',
      isActive: true,
    ),
    CategoryEntity(
      id: 3,
      name: 'Leather',
      slug: 'leather',
      description: 'Handcrafted leather',
      isActive: true,
    ),
    CategoryEntity(
      id: 4,
      name: 'Jewelry',
      slug: 'jewelry',
      description: 'Fine jewelry',
      isActive: true,
    ),
    CategoryEntity(
      id: 5,
      name: 'Fragrance',
      slug: 'fragrance',
      description: 'Artisan perfumes',
      isActive: true,
    ),
  ];
}