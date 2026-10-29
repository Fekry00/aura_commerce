import 'package:aura/core/theme/app_typography.dart';
import 'package:aura/features/category/domain/entities/category_entity.dart';
import 'package:aura/features/category/presentation/cubit/category_cubit.dart';
import 'package:aura/features/category/presentation/widgets/atelier_hero_spotlight.dart';
import 'package:aura/features/category/presentation/widgets/categories_address_bottom_sheet.dart';
import 'package:aura/features/category/presentation/widgets/categories_commission_bottom_sheet.dart';
import 'package:aura/features/category/presentation/widgets/categories_concierge_banner.dart';
import 'package:aura/features/category/presentation/widgets/categories_filter_pills.dart';
import 'package:aura/features/category/presentation/widgets/categories_guarantee_section.dart';
import 'package:aura/features/category/presentation/widgets/categories_header_section.dart';
import 'package:aura/features/category/presentation/widgets/categories_list_section.dart';
import 'package:aura/features/category/presentation/widgets/categories_notifications_bottom_sheet.dart';
import 'package:aura/features/category/presentation/widgets/categories_search_bar.dart';
import 'package:aura/features/category/presentation/widgets/categories_top_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoriesViewBody extends StatelessWidget {
  final TextEditingController searchController;
  final void Function(BuildContext, CategoryEntity) onCategoryTapped;
  final void Function(BuildContext, CategoryEntity?, List<CategoryEntity>)
      onExploreHero;

  const CategoriesViewBody({
    super.key,
    required this.searchController,
    required this.onCategoryTapped,
    required this.onExploreHero,
  });

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<CategoryCubit>();
    final allCategories = cubit.allCategories;
    final selectedIndex = cubit.selectedPillIndex;
    final selectedCategory = cubit.selectedCategory;
    final deliverTo = cubit.deliverTo;

    final quickPills = [
      'All Maisons',
      ...allCategories.map((c) => c.name),
      'Vault Exclusives',
    ];

    return RefreshIndicator(
      color: const Color(0xFF0B3B2C),
      onRefresh: () async {
        searchController.clear();
        cubit.resetFilters();
        await cubit.getCategories();
      },
      child: CustomScrollView(
        physics: const AlwaysScrollableScrollPhysics(
          parent: BouncingScrollPhysics(),
        ),
        slivers: [
          SliverToBoxAdapter(
            child: CategoriesTopBar(
              deliverTo: deliverTo,
              onBackTap: () => Navigator.of(context).maybePop(),
              onDeliverToTap: () => CategoriesAddressBottomSheet.show(
                context,
                currentAddress: deliverTo,
                onAddressSelected: (addr) {
                  cubit.switchDeliveryAddress(addr);
                  Navigator.pop(context);
                },
              ),
              onNotificationsTap: () =>
                  CategoriesNotificationsBottomSheet.show(context),
            ),
          ),
          SliverToBoxAdapter(
            child: CategoriesHeaderSection(
              departmentsCount: allCategories.length,
            ),
          ),
          SliverToBoxAdapter(
            child: CategoriesSearchBar(
              controller: searchController,
              onChanged: (val) => cubit.searchCategories(val),
              onClear: () {
                searchController.clear();
                cubit.searchCategories('');
              },
              onFilterTap: () => CategoriesAddressBottomSheet.show(
                context,
                currentAddress: deliverTo,
                onAddressSelected: (addr) {
                  cubit.switchDeliveryAddress(addr);
                  Navigator.pop(context);
                },
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: CategoriesFilterPills(
              pills: quickPills,
              selectedIndex: selectedIndex,
              onPillSelected: (index, text) => cubit.selectPill(
                index: index,
                pillText: text,
              ),
            ),
          ),
          const SliverToBoxAdapter(
            child: SizedBox(height: AppSpacing.spaceSm),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.gutter,
              ),
              child: AtelierHeroSpotlight(
                category: selectedCategory,
                onExploreTap: () => onExploreHero(
                  context,
                  selectedCategory,
                  allCategories,
                ),
              ),
            ),
          ),
          const SliverToBoxAdapter(
            child: SizedBox(height: AppSpacing.space12),
          ),
          CategoriesListSection(
            onCategoryTap: (cat) => onCategoryTapped(context, cat),
            onRetry: () => cubit.getCategories(),
          ),
          SliverToBoxAdapter(
            child: CategoriesConciergeBanner(
              onTap: () => CategoriesCommissionBottomSheet.show(
                context,
                onSubmit: (note) {
                  Navigator.pop(context);
                  cubit.submitCommissionInquiry(note);
                },
              ),
            ),
          ),
          const SliverToBoxAdapter(
            child: CategoriesGuaranteeSection(),
          ),
        ],
      ),
    );
  }
}
