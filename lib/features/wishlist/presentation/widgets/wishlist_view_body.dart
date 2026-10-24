import 'package:aura/core/routing/main_tab_controller.dart';
import 'package:aura/core/theme/app_colors.dart';
import 'package:aura/core/theme/app_typography.dart';
import 'package:aura/core/utils/functions/custom_snack_bar.dart';
import 'package:aura/features/cart/presentation/cubit/cart_cubit.dart';
import 'package:aura/features/wishlist/presentation/cubit/wishlist_cubit.dart';
import 'package:aura/features/wishlist/presentation/cubit/wishlist_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'wishlist_app_bar.dart';
import 'wishlist_filter_chips.dart';
import 'wishlist_header_section.dart';
import 'wishlist_item_data.dart';
import 'wishlist_items_list.dart';
import 'wishlist_sanctuary_summary_card.dart';
import 'wishlist_sorting_action_bar.dart';

class WishlistViewBody extends StatefulWidget {
  const WishlistViewBody({super.key});

  @override
  State<WishlistViewBody> createState() => _WishlistViewBodyState();
}

class _WishlistViewBodyState extends State<WishlistViewBody> {
  int _selectedCategoryIndex = 0;
  bool _sortAscending = false;

  Future<void> _addAllToCart(
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

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: BlocBuilder<WishlistCubit, WishlistState>(
        builder: (context, state) {
          final allItems = state is WishlistSuccessState
              ? state.wishlist.items
                  .map((e) => WishlistItemData.fromEntity(e))
                  .toList()
              : <WishlistItemData>[];

          // Dynamic category chips
          final rawCategories = allItems
              .map((e) => e.category.trim())
              .where((c) => c.isNotEmpty)
              .toSet()
              .toList();

          final categoryChips = [
            'All (${allItems.length})',
            ...rawCategories,
          ];

          if (_selectedCategoryIndex >= categoryChips.length) {
            _selectedCategoryIndex = 0;
          }

          // Filter by category
          List<WishlistItemData> displayedItems = List.from(allItems);
          if (_selectedCategoryIndex > 0 &&
              _selectedCategoryIndex < categoryChips.length) {
            final selectedCat = categoryChips[_selectedCategoryIndex];
            displayedItems = allItems
                .where((item) => item.category.trim() == selectedCat)
                .toList();
          }

          // Sorting
          if (_sortAscending) {
            displayedItems.sort((a, b) => a.price.compareTo(b.price));
          } else {
            displayedItems.sort((a, b) => b.price.compareTo(a.price));
          }

          // Live dynamic calculations for Sanctuary Summary
          final totalAmount = displayedItems.fold<double>(
            0.0,
            (sum, item) => sum + item.price,
          );
          final itemCount = displayedItems.length;

          return RefreshIndicator(
            color: const Color(0xFF1E382B),
            onRefresh: () async {
              await context.read<WishlistCubit>().fetchWishlist();
            },
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(
                parent: BouncingScrollPhysics(),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const WishlistAppBar(),
                  const SizedBox(height: AppSpacing.spaceSm),
                  WishlistHeaderSection(totalCount: allItems.length),
                  const SizedBox(height: AppSpacing.spaceMd),
                  if (categoryChips.isNotEmpty) ...[
                    WishlistFilterChips(
                      categories: categoryChips,
                      selectedIndex: _selectedCategoryIndex,
                      onSelected: (index) {
                        setState(() {
                          _selectedCategoryIndex = index;
                        });
                      },
                    ),
                    const SizedBox(height: AppSpacing.spaceMd),
                  ],
                  if (allItems.isNotEmpty) ...[
                    WishlistSortingActionBar(
                      onSortTap: () {
                        setState(() {
                          _sortAscending = !_sortAscending;
                        });
                      },
                      onMoveAllToBagTap: () =>
                          _addAllToCart(context, displayedItems),
                    ),
                    const SizedBox(height: AppSpacing.spaceMd),
                  ],
                  if (state is WishlistLoadingState && allItems.isEmpty) ...[
                    Container(
                      height: 200,
                      alignment: Alignment.center,
                      child: const CircularProgressIndicator(
                        color: AppColors.primary,
                      ),
                    ),
                  ] else if (allItems.isEmpty) ...[
                    Container(
                      height: 220,
                      alignment: Alignment.center,
                      padding: const EdgeInsets.symmetric(horizontal: 32),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.favorite_border_rounded,
                            size: 56,
                            color: AppColors.onSurfaceVariant.withValues(alpha: 0.4),
                          ),
                          const SizedBox(height: 12),
                          Text(
                            'Your Wishlist is Empty',
                            style: AppTypography.headlineSm.copyWith(
                              fontWeight: FontWeight.w700,
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            'Tap the heart icon on any product to save it here for later.',
                            textAlign: TextAlign.center,
                            style: AppTypography.bodySm.copyWith(
                              color: AppColors.onSurfaceVariant,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ] else if (displayedItems.isEmpty) ...[
                    Container(
                      height: 160,
                      alignment: Alignment.center,
                      child: Text(
                        'No products found in this category',
                        style: AppTypography.bodySm.copyWith(
                          color: AppColors.onSurfaceVariant,
                        ),
                      ),
                    ),
                  ] else ...[
                    WishlistItemsList(
                      items: displayedItems,
                      onRemoveItem: (id) {
                        context.read<WishlistCubit>().removeItem(id);
                        showCustomSnackBar(
                          context,
                          message: 'Removed from Wishlist',
                          type: SnackBarType.info,
                        );
                      },
                      onMoveToBag: (id) async {
                        final idInt = int.tryParse(id);
                        if (idInt != null) {
                          await context
                              .read<CartCubit>()
                              .addToCart(productId: idInt);
                        }
                        if (!context.mounted) return;
                        showCustomSnackBar(
                          context,
                          message: 'Added to Bag',
                          type: SnackBarType.success,
                        );
                        MainTabController.switchTab(2);
                      },
                    ),
                  ],
                  if (allItems.isNotEmpty) ...[
                    const SizedBox(height: AppSpacing.spaceLg),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppSpacing.margin,
                      ),
                      child: WishlistSanctuarySummaryCard(
                        totalAmount: totalAmount,
                        itemCount: itemCount,
                        onAddAllTap: () =>
                            _addAllToCart(context, displayedItems),
                      ),
                    ),
                  ],
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
