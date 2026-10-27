import 'package:aura/core/theme/app_colors.dart';
import 'package:aura/features/category/presentation/controllers/categories_controller.dart';
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

class CategoriesView extends StatefulWidget {
  const CategoriesView({super.key});

  @override
  State<CategoriesView> createState() => _CategoriesViewState();
}

class _CategoriesViewState extends State<CategoriesView> {
  final CategoriesController _controller = CategoriesController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final allCategories = context.watch<CategoryCubit>().allCategories;
    final quickPills = [
      'All Maisons',
      ...allCategories.map((c) => c.name),
      'Vault Exclusives',
    ];

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        bottom: false,
        child: RefreshIndicator(
          color: const Color(0xFF0B3B2C),
          onRefresh: () => _controller.onRefresh(
            context,
            onReset: () => setState(() {}),
          ),
          child: CustomScrollView(
            physics: const AlwaysScrollableScrollPhysics(
              parent: BouncingScrollPhysics(),
            ),
            slivers: [
              SliverToBoxAdapter(
                child: CategoriesTopBar(
                  deliverTo: _controller.deliverTo,
                  onBackTap: () => Navigator.of(context).maybePop(),
                  onDeliverToTap: () => CategoriesAddressBottomSheet.show(
                    context,
                    currentAddress: _controller.deliverTo,
                    onAddressSelected: (addr) => _controller.onAddressSelected(
                      context,
                      title: addr,
                      onUpdated: () => setState(() {}),
                    ),
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
                  controller: _controller.searchController,
                  onChanged: (val) => _controller.onSearchChanged(context, val),
                  onClear: () => _controller.clearSearch(
                    context,
                    () => setState(() {}),
                  ),
                  onFilterTap: () => CategoriesAddressBottomSheet.show(
                    context,
                    currentAddress: _controller.deliverTo,
                    onAddressSelected: (addr) => _controller.onAddressSelected(
                      context,
                      title: addr,
                      onUpdated: () => setState(() {}),
                    ),
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: CategoriesFilterPills(
                  pills: quickPills,
                  selectedIndex: _controller.selectedPillIndex,
                  onPillSelected: (index, text) => _controller.onPillSelected(
                    context,
                    index: index,
                    pillText: text,
                    allCategories: allCategories,
                    onUpdate: () => setState(() {}),
                  ),
                ),
              ),
              const SliverToBoxAdapter(child: SizedBox(height: 8)),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: AtelierHeroSpotlight(
                    category: _controller.selectedCategory,
                    onExploreTap: () => _controller.onExploreHero(
                      context,
                      allCategories,
                    ),
                  ),
                ),
              ),
              const SliverToBoxAdapter(child: SizedBox(height: 12)),
              CategoriesListSection(
                onCategoryTap: (cat) =>
                    _controller.onCategoryTapped(context, cat),
                onRetry: () => context.read<CategoryCubit>().getCategories(),
              ),
              SliverToBoxAdapter(
                child: CategoriesConciergeBanner(
                  onTap: () => CategoriesCommissionBottomSheet.show(
                    context,
                    onSubmit: (note) =>
                        _controller.onCommissionSubmitted(context, note),
                  ),
                ),
              ),
              const SliverToBoxAdapter(
                child: CategoriesGuaranteeSection(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
