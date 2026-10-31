import 'package:aura/core/theme/app_typography.dart';
import 'package:aura/features/wishlist/presentation/cubit/wishlist_cubit.dart';
import 'package:aura/features/wishlist/presentation/cubit/wishlist_state.dart';
import 'package:aura/features/wishlist/presentation/models/wishlist_summary_data.dart';
import 'package:aura/features/wishlist/presentation/widgets/wishlist_app_bar.dart';
import 'package:aura/features/wishlist/presentation/widgets/wishlist_category_empty_view.dart';
import 'package:aura/features/wishlist/presentation/widgets/wishlist_empty_view.dart';
import 'package:aura/features/wishlist/presentation/widgets/wishlist_filter_chips.dart';
import 'package:aura/features/wishlist/presentation/widgets/wishlist_header_section.dart';
import 'package:aura/features/wishlist/presentation/widgets/wishlist_item_data.dart';
import 'package:aura/features/wishlist/presentation/widgets/wishlist_items_list.dart';
import 'package:aura/features/wishlist/presentation/widgets/wishlist_sanctuary_summary_card.dart';
import 'package:aura/features/wishlist/presentation/widgets/wishlist_shimmer_skeleton.dart';
import 'package:aura/features/wishlist/presentation/widgets/wishlist_sorting_action_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WishlistViewBody extends StatefulWidget {
  const WishlistViewBody({super.key});

  @override
  State<WishlistViewBody> createState() => _WishlistViewBodyState();
}

class _WishlistViewBodyState extends State<WishlistViewBody> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (context.read<WishlistCubit>().state is WishlistInitialState) {
        context.read<WishlistCubit>().fetchWishlist();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: BlocBuilder<WishlistCubit, WishlistState>(
        builder: (context, state) {
          final cubit = context.read<WishlistCubit>();
          final effectiveSuccess = state is WishlistSuccessState
              ? state
              : (cubit.currentWishlist != null
                  ? WishlistSuccessState(wishlist: cubit.currentWishlist!)
                  : null);
          final allItems = effectiveSuccess?.allItems ?? const <WishlistItemData>[];
          final displayedItems = effectiveSuccess?.displayedItems ?? const <WishlistItemData>[];
          final categoryChips = effectiveSuccess?.categoryChips ?? const <String>[];
          final selectedCategoryIndex = effectiveSuccess?.selectedCategoryIndex ?? 0;
          final sortLabel = effectiveSuccess?.sortLabel ?? 'Price: High to Low';
          final summary = effectiveSuccess?.summary ?? WishlistSummaryData.empty;

          final isLoading = (state is WishlistLoadingState || state is WishlistInitialState) && allItems.isEmpty;

          return RefreshIndicator(
            color: const Color(0xFF1E382B),
            onRefresh: cubit.fetchWishlist,
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const WishlistAppBar(),
                  const SizedBox(height: AppSpacing.spaceSm),
                  WishlistHeaderSection(totalCount: allItems.length),
                  const SizedBox(height: AppSpacing.spaceMd),
                  if (isLoading) ...[
                    const WishlistShimmerSkeleton(),
                  ] else ...[
                    if (categoryChips.isNotEmpty) ...[
                      WishlistFilterChips(
                        categories: categoryChips,
                        selectedIndex: selectedCategoryIndex,
                        onSelected: cubit.selectCategory,
                      ),
                      const SizedBox(height: AppSpacing.spaceMd),
                    ],
                    if (allItems.isNotEmpty) ...[
                      WishlistSortingActionBar(
                        sortLabel: sortLabel,
                        onSortTap: cubit.toggleSort,
                        onMoveAllToBagTap: cubit.addAllToCart,
                      ),
                      const SizedBox(height: AppSpacing.spaceMd),
                    ],
                    if (allItems.isEmpty) ...[
                      const WishlistEmptyView(),
                    ] else if (displayedItems.isEmpty) ...[
                      const WishlistCategoryEmptyView(),
                    ] else ...[
                      WishlistItemsList(
                        items: displayedItems,
                        onRemoveItem: cubit.removeItem,
                        onMoveToBag: cubit.moveToBag,
                      ),
                    ],
                    if (allItems.isNotEmpty) ...[
                      const SizedBox(height: AppSpacing.spaceLg),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.margin),
                        child: WishlistSanctuarySummaryCard(
                          summary: summary,
                          onAddAllTap: cubit.addAllToCart,
                        ),
                      ),
                    ],
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
