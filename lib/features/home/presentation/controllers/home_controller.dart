import 'package:aura/core/routing/main_tab_controller.dart';
import 'package:aura/core/routing/routes.dart';
import 'package:aura/core/utils/functions/custom_snack_bar.dart';
import 'package:aura/features/cart/presentation/cubit/cart_cubit.dart';
import 'package:aura/features/home/domain/entities/sub_entities/banner_entity.dart';
import 'package:aura/features/home/domain/entities/sub_entities/category_entity.dart';
import 'package:aura/features/home/domain/entities/sub_entities/product_highlight_entity.dart';
import 'package:aura/features/home/presentation/cubit/home_cubit.dart';
import 'package:aura/features/home/presentation/widgets/home_notifications_sheet.dart';
import 'package:aura/features/profile/data/services/user_address_manager.dart';
import 'package:aura/features/profile/presentation/widgets/saved_addresses_bottom_sheet.dart';
import 'package:aura/features/wishlist/presentation/cubit/wishlist_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'curated_drop_timer_controller.dart';

class HomeController {
  final TextEditingController searchController = TextEditingController();
  final CuratedDropTimerController timerController =
      CuratedDropTimerController();

  int? selectedCategoryId;
  String? selectedCategoryName;
  int selectedTab = 0; // 0: All, 1: Popular

  void init() {
    timerController.startCountdown();
  }

  void dispose() {
    searchController.dispose();
    timerController.dispose();
  }

  List<ProductHighlightEntity>? getFilteredProducts(
    List<ProductHighlightEntity>? highlights,
  ) {
    if (highlights == null) return null;
    var filtered = highlights;
    if (selectedCategoryId != null) {
      filtered =
          filtered.where((p) => p.categoryId == selectedCategoryId).toList();
    }
    if (selectedTab == 1) {
      filtered = filtered.where((p) => p.isPopular).toList();
    }
    return filtered;
  }

  String getEmptyMessage() {
    if (selectedCategoryId != null) {
      return 'No products found in $selectedCategoryName.';
    }
    if (selectedTab == 1) {
      return 'No popular products found right now.';
    }
    return 'No products available right now.';
  }

  void onCategorySelected(CategoryEntity? cat, VoidCallback onUpdate) {
    if (cat == null) {
      selectedCategoryId = null;
      selectedCategoryName = null;
    } else {
      selectedCategoryId = cat.id;
      selectedCategoryName = cat.name;
    }
    onUpdate();
  }

  void onViewAllCategories(BuildContext context, VoidCallback onUpdate) {
    selectedCategoryId = null;
    selectedCategoryName = null;
    onUpdate();
    Navigator.pushNamed(context, Routes.categoriesView);
  }

  void onTabChanged(int index, VoidCallback onUpdate) {
    if (selectedTab == index) return;
    selectedTab = index;
    onUpdate();
  }

  Future<void> onRefresh(BuildContext context) async {
    await context.read<HomeCubit>().fetchHomeFeed();
  }

  void onVoiceSearchTap(BuildContext context) {
    showCustomSnackBar(
      context,
      message: 'Voice search is coming soon!',
      type: SnackBarType.info,
    );
  }

  void onFilterTap(BuildContext context) {
    showCustomSnackBar(
      context,
      message: 'Opening filter options...',
      type: SnackBarType.info,
    );
  }

  void onSearchSubmitted(BuildContext context, String query) {
    if (query.trim().isEmpty) return;
    // In production, delegate query handling or route to search view.
  }

  void onExploreBanner(BuildContext context, BannerEntity banner) {
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

  void onProductTap(BuildContext context, ProductHighlightEntity product) {
    Navigator.pushNamed(
      context,
      Routes.productDetailsView,
      arguments: product.toProductItemEntity(),
    );
  }

  void onFavoriteTap(BuildContext context, ProductHighlightEntity item) {
    final willBeFavorite = !item.isFavorite;
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
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          willBeFavorite
              ? 'Added ${item.title} to Wishlist ❤️'
              : 'Removed ${item.title} from Wishlist',
        ),
        duration: const Duration(seconds: 1),
      ),
    );
  }

  void onAddToCart(BuildContext context, ProductHighlightEntity item) {
    final intId = int.tryParse(item.id);
    if (intId != null) {
      context.read<CartCubit>().addToCart(productId: intId);
    }
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Added ${item.title} to bag! 🛒'),
        duration: const Duration(seconds: 1),
      ),
    );
  }

  void onArchiveBannerTap() {
    MainTabController.switchTab(1);
  }

  String getDeliveryAddressText() {
    final defaultAddress = UserAddressManager.getDefaultAddress();
    return defaultAddress != null
        ? (defaultAddress.address.isNotEmpty
            ? defaultAddress.address
            : defaultAddress.label)
        : 'Manage delivery';
  }

  void onDeliveryLocationTap(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => const SavedAddressesBottomSheet(),
    );
  }

  void onNotificationsTap(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (_) => const HomeNotificationsSheet(),
    );
  }
}
