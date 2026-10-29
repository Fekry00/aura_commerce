import 'package:aura/core/routing/main_tab_controller.dart';
import 'package:aura/core/routing/routes.dart';
import 'package:aura/core/theme/app_typography.dart';
import 'package:aura/core/utils/functions/custom_snack_bar.dart';
import 'package:aura/features/cart/presentation/cubit/cart_cubit.dart';
import 'package:aura/features/home/domain/entities/sub_entities/banner_entity.dart';
import 'package:aura/features/home/domain/entities/sub_entities/product_highlight_entity.dart';
import 'package:aura/features/home/presentation/cubit/home_cubit.dart';
import 'package:aura/features/home/presentation/cubit/home_state.dart';
import 'package:aura/features/home/presentation/widgets/atelier_archive_banner.dart';
import 'package:aura/features/home/presentation/widgets/curated_highlights_header.dart';
import 'package:aura/features/home/presentation/widgets/home_categories_section.dart';
import 'package:aura/features/home/presentation/widgets/home_curated_drop_timer.dart';
import 'package:aura/features/home/presentation/widgets/home_hero_banner.dart';
import 'package:aura/features/home/presentation/widgets/home_products_grid.dart';
import 'package:aura/features/wishlist/presentation/cubit/wishlist_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeFeedSection extends StatelessWidget {
  const HomeFeedSection({super.key, required this.state});

  final HomeSuccessState state;

  void _onExploreBanner(BuildContext context, BannerEntity banner) {
    if (banner.linkType == 'CATEGORY' && banner.linkTargetId != null) {
      showCustomSnackBar(
        context,
        message: 'Exploring Category #${banner.linkTargetId}...',
        type: SnackBarType.info,
      );
    } else {
      showCustomSnackBar(
        context,
        message: 'Viewing ${banner.title}',
        type: SnackBarType.info,
      );
    }
  }

  void _onDropTap(BuildContext context) {
    showCustomSnackBar(
      context,
      message:
          'Drop 04 starts in ${state.formattedDropHours} hours and ${state.formattedDropMinutes} minutes!',
      type: SnackBarType.info,
    );
  }

  void _onFavoriteTap(BuildContext context, ProductHighlightEntity item) {
    context.read<HomeCubit>().toggleFavorite(
          item.id,
          currentIsFavorite: item.isFavorite,
        );
    final intId = int.tryParse(item.id);
    if (intId != null) {
      context.read<WishlistCubit>().toggleWishlist(
            intId,
            isCurrentlyFavorite: item.isFavorite,
          );
    }
  }

  void _onAddToCart(BuildContext context, ProductHighlightEntity item) {
    final intId = int.tryParse(item.id);
    if (intId != null) {
      context.read<CartCubit>().addToCart(productId: intId);
    }
  }

  void _onProductTap(BuildContext context, ProductHighlightEntity product) {
    Navigator.pushNamed(
      context,
      Routes.productDetailsView,
      arguments: product.toProductItemEntity(),
    );
  }

  void _onViewAllCategories(BuildContext context) {
    context.read<HomeCubit>().clearCategorySelection();
    Navigator.pushNamed(context, Routes.categoriesView);
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<HomeCubit>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        HomeHeroBanner(
          banners: state.homeFeed.banners,
          onExploreTap: (banner) => _onExploreBanner(context, banner),
        ),
        const SizedBox(height: AppSpacing.spaceSm),
        HomeCuratedDropTimer(
          hours: state.formattedDropHours,
          minutes: state.formattedDropMinutes,
          seconds: state.formattedDropSeconds,
          onTap: () => _onDropTap(context),
        ),
        const SizedBox(height: AppSpacing.spaceLg),
        HomeCategoriesSection(
          categories: state.homeFeed.categories,
          selectedCategoryId: state.selectedCategoryId,
          onCategorySelected: (cat) => cubit.selectCategory(cat),
          onViewAllTap: () => _onViewAllCategories(context),
        ),
        const SizedBox(height: AppSpacing.spaceLg),
        CuratedHighlightsHeader(
          selectedIndex: state.selectedTab,
          onTabChanged: (index) => cubit.selectTab(index),
        ),
        const SizedBox(height: AppSpacing.spaceMd),
        HomeProductsGrid(
          products: state.filteredProducts,
          emptyMessage: state.emptyProductsMessage,
          onFavoriteTap: (item) => _onFavoriteTap(context, item),
          onAddToCart: (item) => _onAddToCart(context, item),
          onProductTap: (item) => _onProductTap(context, item),
        ),
        const SizedBox(height: AppSpacing.spaceMd),
        AtelierArchiveBanner(
          onTap: () => MainTabController.switchTab(1),
        ),
        const SizedBox(height: AppSpacing.spaceXl * 2),
      ],
    );
  }
}
