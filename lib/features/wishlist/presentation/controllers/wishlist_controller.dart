import 'package:aura/core/routing/main_tab_controller.dart';
import 'package:aura/core/utils/functions/custom_snack_bar.dart';
import 'package:aura/features/cart/presentation/cubit/cart_cubit.dart';
import 'package:aura/features/wishlist/presentation/cubit/wishlist_cubit.dart';
import 'package:aura/features/wishlist/presentation/widgets/wishlist_item_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WishlistController {
  int selectedCategoryIndex = 0;
  bool sortAscending = false;

  String get sortLabel =>
      sortAscending ? 'Price: Low to High' : 'Price: High to Low';

  List<String> getCategoryChips(List<WishlistItemData> allItems) {
    final rawCategories = allItems
        .map((e) => e.category.trim())
        .where((c) => c.isNotEmpty)
        .toSet()
        .toList();

    return [
      'All (${allItems.length})',
      ...rawCategories,
    ];
  }

  List<WishlistItemData> getFilteredAndSortedItems(
    List<WishlistItemData> allItems,
    List<String> categoryChips,
  ) {
    if (selectedCategoryIndex >= categoryChips.length) {
      selectedCategoryIndex = 0;
    }

    List<WishlistItemData> displayed = List.from(allItems);
    if (selectedCategoryIndex > 0 &&
        selectedCategoryIndex < categoryChips.length) {
      final selectedCat = categoryChips[selectedCategoryIndex];
      displayed = allItems
          .where((item) => item.category.trim() == selectedCat)
          .toList();
    }

    if (sortAscending) {
      displayed.sort((a, b) => a.price.compareTo(b.price));
    } else {
      displayed.sort((a, b) => b.price.compareTo(a.price));
    }

    return displayed;
  }

  void onCategorySelected(int index, VoidCallback onUpdate) {
    if (selectedCategoryIndex == index) return;
    selectedCategoryIndex = index;
    onUpdate();
  }

  void onToggleSort(VoidCallback onUpdate) {
    sortAscending = !sortAscending;
    onUpdate();
  }

  Future<void> onRemoveItem(BuildContext context, String id) async {
    context.read<WishlistCubit>().removeItem(id);
    showCustomSnackBar(
      context,
      message: 'Removed from Wishlist',
      type: SnackBarType.info,
    );
  }

  Future<void> onMoveToBag(BuildContext context, String id) async {
    final idInt = int.tryParse(id);
    if (idInt != null) {
      await context.read<CartCubit>().addToCart(productId: idInt);
    }
    if (!context.mounted) return;
    showCustomSnackBar(
      context,
      message: 'Added to Bag',
      type: SnackBarType.success,
    );
    MainTabController.switchTab(2);
  }

  Future<void> onAddAllToCart(
    BuildContext context,
    List<WishlistItemData> itemsToAdd,
  ) async {
    final availableItems = itemsToAdd
        .where((i) => !i.stockStatus.toLowerCase().contains('out of stock'))
        .toList();

    if (availableItems.isEmpty) {
      showCustomSnackBar(
        context,
        message: 'No available items to add to cart',
        type: SnackBarType.info,
      );
      return;
    }

    for (final item in availableItems) {
      final idInt = int.tryParse(item.id);
      if (idInt != null) {
        await context.read<CartCubit>().addToCart(productId: idInt);
      }
    }

    if (!context.mounted) return;
    showCustomSnackBar(
      context,
      message: 'Added ${availableItems.length} item(s) to Cart',
      type: SnackBarType.success,
    );
    MainTabController.switchTab(2);
  }

  Future<void> onRefresh(BuildContext context) async {
    await context.read<WishlistCubit>().fetchWishlist();
  }
}
