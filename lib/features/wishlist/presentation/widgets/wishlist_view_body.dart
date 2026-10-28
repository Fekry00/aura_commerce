import 'package:aura/core/theme/app_typography.dart';
import 'package:aura/core/widgets/shimmer/wishlist_shimmer_skeleton.dart';
import 'package:aura/features/wishlist/presentation/controllers/wishlist_controller.dart';
import 'package:aura/features/wishlist/presentation/cubit/wishlist_cubit.dart';
import 'package:aura/features/wishlist/presentation/cubit/wishlist_state.dart';
import 'package:aura/features/wishlist/presentation/models/wishlist_summary_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'wishlist_app_bar.dart';
import 'wishlist_category_empty_view.dart';
import 'wishlist_empty_view.dart';
import 'wishlist_filter_chips.dart';
import 'wishlist_header_section.dart';
import 'wishlist_item_data.dart';
import 'wishlist_items_list.dart';
import 'wishlist_sanctuary_summary_card.dart';
import 'wishlist_sorting_action_bar.dart';

/// Pure declarative body for Wishlist view. Zero logic, zero math.
class WishlistViewBody extends StatefulWidget {
  final WishlistController? controller;

  const WishlistViewBody({super.key, this.controller});

  @override
  State<WishlistViewBody> createState() => _WishlistViewBodyState();
}

class _WishlistViewBodyState extends State<WishlistViewBody> {
  late final WishlistController _controller;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? WishlistController();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: BlocBuilder<WishlistCubit, WishlistState>(
        builder: (context, state) {
          final allItems = state is WishlistSuccessState
              ? state.wishlist.items
                  .map(WishlistItemData.fromEntity)
                  .toList()
              : <WishlistItemData>[];

          final selectedCategoryIndex = state is WishlistSuccessState
              ? state.selectedCategoryIndex
              : 0;
          final sortAscending = state is WishlistSuccessState
              ? state.sortAscending
              : false;

          final categoryChips = _controller.getCategoryChips(allItems);
          final displayedItems = _controller.getFilteredAndSortedItems(
            allItems,
            categoryChips,
            selectedCategoryIndex: selectedCategoryIndex,
            sortAscending: sortAscending,
          );
          final summary = WishlistSummaryData.fromItems(displayedItems);

          return RefreshIndicator(
            color: const Color(0xFF1E382B),
            onRefresh: () => _controller.onRefresh(context),
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
                      selectedIndex: selectedCategoryIndex,
                      onSelected: (index) =>
                          _controller.onCategorySelected(context, index),
                    ),
                    const SizedBox(height: AppSpacing.spaceMd),
                  ],
                  if (allItems.isNotEmpty) ...[
                    WishlistSortingActionBar(
                      sortLabel: _controller.getSortLabel(sortAscending),
                      onSortTap: () => _controller.onToggleSort(context),
                      onMoveAllToBagTap: () => _controller.onAddAllToCart(
                        context,
                        displayedItems,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.spaceMd),
                  ],
                  if (state is WishlistLoadingState && allItems.isEmpty) ...[
                    const WishlistShimmerSkeleton(),
                  ] else if (allItems.isEmpty) ...[
                    const WishlistEmptyView(),
                  ] else if (displayedItems.isEmpty) ...[
                    const WishlistCategoryEmptyView(),
                  ] else ...[
                    WishlistItemsList(
                      items: displayedItems,
                      onRemoveItem: (id) =>
                          _controller.onRemoveItem(context, id),
                      onMoveToBag: (id) =>
                          _controller.onMoveToBag(context, id),
                    ),
                  ],
                  if (allItems.isNotEmpty) ...[
                    const SizedBox(height: AppSpacing.spaceLg),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppSpacing.margin,
                      ),
                      child: WishlistSanctuarySummaryCard(
                        summary: summary,
                        onAddAllTap: () => _controller.onAddAllToCart(
                          context,
                          displayedItems,
                        ),
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
