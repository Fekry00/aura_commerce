import 'package:aura/core/theme/app_colors.dart';
import 'package:aura/core/theme/app_typography.dart';
import 'package:aura/features/home/domain/entities/sub_entities/product_highlight_entity.dart';
import 'package:aura/features/home/presentation/cubit/home_cubit.dart';
import 'package:aura/features/home/presentation/cubit/home_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'atelier_archive_banner.dart';
import 'curated_highlights_header.dart';
import 'home_app_bar.dart';
import 'home_categories_section.dart';
import 'home_curated_drop_timer.dart';
import 'home_hero_banner.dart';
import 'home_products_grid.dart';
import 'home_search_bar.dart';

class HomeViewBody extends StatefulWidget {
  const HomeViewBody({super.key});

  @override
  State<HomeViewBody> createState() => _HomeViewBodyState();
}

class _HomeViewBodyState extends State<HomeViewBody> {
  int? _selectedCategoryId;
  String? _selectedCategoryName;
  int _selectedTab = 0; // 0: All, 1: Popular

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          final homeFeed = state is HomeSuccessState ? state.homeFeed : null;
          final banners = homeFeed?.banners;
          final categories = homeFeed?.categories;

          List<ProductHighlightEntity>? filteredProducts = homeFeed?.highlights;
          if (filteredProducts != null) {
            if (_selectedCategoryId != null) {
              filteredProducts = filteredProducts
                  .where((p) => p.categoryId == _selectedCategoryId)
                  .toList();
            }
            if (_selectedTab == 1) {
              filteredProducts = filteredProducts
                  .where((p) => p.isPopular)
                  .toList();
            }
          }

          final emptyMsg = _selectedCategoryId != null
              ? 'No products found in $_selectedCategoryName.'
              : (_selectedTab == 1
                  ? 'No popular products found right now.'
                  : 'No products available right now.');

          return RefreshIndicator(
            color: const Color(0xFF1E382B),
            onRefresh: () async {
              await context.read<HomeCubit>().fetchHomeFeed();
            },
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(
                parent: BouncingScrollPhysics(),
              ),
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.margin),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: AppSpacing.spaceSm),
                  const HomeAppBar(),
                  const SizedBox(height: AppSpacing.spaceMd),
                  const HomeSearchBar(),
                  const SizedBox(height: AppSpacing.spaceMd),
                  if (state is HomeLoadingState && homeFeed == null) ...[
                    Container(
                      height: 380,
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.04),
                        borderRadius: BorderRadius.circular(24),
                      ),
                      child: const Center(
                        child: CircularProgressIndicator(
                          color: AppColors.primary,
                        ),
                      ),
                    ),
                  ] else ...[
                    HomeHeroBanner(banners: banners),
                  ],
                  const SizedBox(height: AppSpacing.spaceSm),
                  const HomeCuratedDropTimer(),
                  const SizedBox(height: AppSpacing.spaceLg),
                  HomeCategoriesSection(
                    categories: categories,
                    selectedCategoryId: _selectedCategoryId,
                    onCategorySelected: (cat) {
                      setState(() {
                        if (cat == null) {
                          _selectedCategoryId = null;
                          _selectedCategoryName = null;
                        } else {
                          _selectedCategoryId = cat.id;
                          _selectedCategoryName = cat.name;
                        }
                      });
                    },
                    onViewAllTap: () {
                      setState(() {
                        _selectedCategoryId = null;
                        _selectedCategoryName = null;
                      });
                    },
                  ),
                  const SizedBox(height: AppSpacing.spaceLg),
                  CuratedHighlightsHeader(
                    selectedIndex: _selectedTab,
                    onTabChanged: (index) {
                      setState(() => _selectedTab = index);
                    },
                  ),
                  const SizedBox(height: AppSpacing.spaceMd),
                  HomeProductsGrid(
                    products: filteredProducts,
                    emptyMessage: emptyMsg,
                  ),
                  const SizedBox(height: AppSpacing.spaceMd),
                  const AtelierArchiveBanner(),
                  const SizedBox(height: AppSpacing.spaceXl * 2),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
