import 'package:aura/core/routing/main_tab_controller.dart';
import 'package:aura/core/theme/app_typography.dart';
import 'package:flutter/material.dart';
import 'wishlist_app_bar.dart';
import 'wishlist_filter_chips.dart';
import 'wishlist_header_section.dart';
import 'wishlist_item_data.dart';
import 'wishlist_items_list.dart';
import 'wishlist_sanctuary_summary_card.dart';
import 'wishlist_sorting_action_bar.dart';

class WishlistViewBody extends StatelessWidget {
  const WishlistViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const WishlistAppBar(),
            const SizedBox(height: AppSpacing.spaceSm),
            const WishlistHeaderSection(),
            const SizedBox(height: AppSpacing.spaceMd),
            const WishlistFilterChips(),
            const SizedBox(height: AppSpacing.spaceMd),
            WishlistSortingActionBar(
              onMoveAllToBagTap: () => MainTabController.switchTab(2),
            ),
            const SizedBox(height: AppSpacing.spaceMd),
            WishlistItemsList(
              items: WishlistItemData.sampleItems,
              onMoveToBag: (_) => MainTabController.switchTab(2),
            ),
            const SizedBox(height: AppSpacing.spaceLg),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.margin),
              child: WishlistSanctuarySummaryCard(
                onAddAllTap: () => MainTabController.switchTab(2),
              ),
            ),
            const SizedBox(height: AppSpacing.spaceXl * 2),
          ],
        ),
      ),
    );
  }
}
