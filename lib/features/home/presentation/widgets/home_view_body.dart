import 'package:aura/core/theme/app_typography.dart';
import 'package:aura/core/widgets/shimmer/home_shimmer_skeleton.dart';
import 'package:aura/features/home/presentation/controllers/home_controller.dart';
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
import 'home_server_error_banner.dart';

class HomeViewBody extends StatefulWidget {
  const HomeViewBody({super.key});

  @override
  State<HomeViewBody> createState() => _HomeViewBodyState();
}

class _HomeViewBodyState extends State<HomeViewBody> {
  final HomeController _controller = HomeController();

  @override
  void initState() {
    super.initState();
    _controller.init();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          final homeFeed = state is HomeSuccessState ? state.homeFeed : null;
          final banners = homeFeed?.banners;
          final categories = homeFeed?.categories;
          final filteredProducts =
              _controller.getFilteredProducts(homeFeed?.highlights);
          final emptyMsg = _controller.getEmptyMessage();

          return RefreshIndicator(
            color: const Color(0xFF1E382B),
            onRefresh: () => _controller.onRefresh(context),
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(
                parent: BouncingScrollPhysics(),
              ),
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.margin),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: AppSpacing.spaceSm),
                  HomeAppBar(
                    deliveryText: _controller.getDeliveryAddressText(),
                    onLocationTap: () =>
                        _controller.onDeliveryLocationTap(context),
                    onNotificationsTap: () =>
                        _controller.onNotificationsTap(context),
                  ),
                  const SizedBox(height: AppSpacing.spaceMd),
                  HomeSearchBar(
                    controller: _controller.searchController,
                    onSubmitted: (query) =>
                        _controller.onSearchSubmitted(context, query),
                    onVoiceSearchTap: () =>
                        _controller.onVoiceSearchTap(context),
                    onFilterTap: () => _controller.onFilterTap(context),
                  ),
                  const SizedBox(height: AppSpacing.spaceMd),
                  if (state is HomeLoadingState && homeFeed == null) ...[
                    const HomeShimmerSkeleton(),
                  ] else ...[
                    if (state is HomeErrorState && homeFeed == null) ...[
                      HomeServerErrorBanner(
                        onRetry: () =>
                            context.read<HomeCubit>().fetchHomeFeed(),
                      ),
                      const SizedBox(height: AppSpacing.spaceMd),
                    ],
                    HomeHeroBanner(
                      banners: banners,
                      onExploreTap: (banner) =>
                          _controller.onExploreBanner(context, banner),
                    ),
                    const SizedBox(height: AppSpacing.spaceSm),
                    ListenableBuilder(
                      listenable: _controller.timerController,
                      builder: (context, _) {
                        return HomeCuratedDropTimer(
                          hours: _controller.timerController.formattedHours,
                          minutes: _controller.timerController.formattedMinutes,
                          seconds: _controller.timerController.formattedSeconds,
                          onTap: () =>
                              _controller.timerController.onDropTap(context),
                        );
                      },
                    ),
                    const SizedBox(height: AppSpacing.spaceLg),
                    HomeCategoriesSection(
                      categories: categories,
                      selectedCategoryId: _controller.selectedCategoryId,
                      onCategorySelected: (cat) => _controller
                          .onCategorySelected(cat, () => setState(() {})),
                      onViewAllTap: () => _controller
                          .onViewAllCategories(context, () => setState(() {})),
                    ),
                    const SizedBox(height: AppSpacing.spaceLg),
                    CuratedHighlightsHeader(
                      selectedIndex: _controller.selectedTab,
                      onTabChanged: (index) =>
                          _controller.onTabChanged(index, () => setState(() {})),
                    ),
                    const SizedBox(height: AppSpacing.spaceMd),
                    HomeProductsGrid(
                      products: filteredProducts,
                      emptyMessage: emptyMsg,
                      onFavoriteTap: (item) =>
                          _controller.onFavoriteTap(context, item),
                      onAddToCart: (item) =>
                          _controller.onAddToCart(context, item),
                      onProductTap: (item) =>
                          _controller.onProductTap(context, item),
                    ),
                    const SizedBox(height: AppSpacing.spaceMd),
                    AtelierArchiveBanner(
                      onTap: _controller.onArchiveBannerTap,
                    ),
                    const SizedBox(height: AppSpacing.spaceXl * 2),
                  ],
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
