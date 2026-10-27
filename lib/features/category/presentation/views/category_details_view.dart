import 'package:aura/core/theme/app_colors.dart';
import 'package:aura/features/category/domain/entities/category_entity.dart';
import 'package:aura/features/category/presentation/controllers/category_details_controller.dart';
import 'package:aura/features/category/presentation/cubit/category_cubit.dart';
import 'package:aura/features/category/presentation/cubit/category_state.dart';
import 'package:aura/features/category/presentation/utils/category_ui_helper.dart';
import 'package:aura/features/category/presentation/widgets/category_details_meta_section.dart';
import 'package:aura/features/category/presentation/widgets/category_details_products_grid.dart';
import 'package:aura/features/category/presentation/widgets/category_details_products_header.dart';
import 'package:aura/features/category/presentation/widgets/category_details_sliver_app_bar.dart';
import 'package:aura/features/category/presentation/widgets/category_details_subdepartments_tabs.dart';
import 'package:aura/features/product/domain/entities/sub_entities/product_item_entity.dart';
import 'package:aura/features/product/presentation/cubit/product_cubit.dart';
import 'package:aura/features/product/presentation/cubit/product_state.dart';
import 'package:aura/features/wishlist/presentation/cubit/wishlist_cubit.dart';
import 'package:aura/features/wishlist/presentation/cubit/wishlist_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoryDetailsView extends StatefulWidget {
  const CategoryDetailsView({
    super.key,
    required this.category,
    this.initialSubDepartment,
  });

  final CategoryEntity category;
  final String? initialSubDepartment;

  @override
  State<CategoryDetailsView> createState() => _CategoryDetailsViewState();
}

class _CategoryDetailsViewState extends State<CategoryDetailsView> {
  late final CategoryDetailsController _controller;

  @override
  void initState() {
    super.initState();
    _controller = CategoryDetailsController(
      category: widget.category,
      initialSubDepartment: widget.initialSubDepartment,
    );
    _controller.init(context);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final subDepartments = CategoryUiHelper.getEffectiveSubDepartments(
      _controller.currentCategory,
    );
    final productState = context.watch<ProductCubit>().state;
    final wishlistState = context.watch<WishlistCubit>().state;

    final wishlistIds = wishlistState is WishlistSuccessState
        ? wishlistState.wishlist.items.map((i) => i.id).toSet()
        : <String>{};

    final List<ProductItemEntity> allProducts =
        (productState is ProductListSuccessState)
            ? productState.products
            : const <ProductItemEntity>[];

    final displayedProducts = _controller.getFilteredProducts(
      allProducts: allProducts,
      subDepartments: subDepartments,
    );

    return BlocListener<CategoryCubit, CategoryState>(
      listener: (context, state) {
        if (state is GetCategoryDetailsSuccessState) {
          setState(() {
            _controller.updateCategory(state.category);
          });
        }
      },
      child: Scaffold(
        backgroundColor: AppColors.background,
        body: RefreshIndicator(
          color: const Color(0xFF0B3B2C),
          onRefresh: () => _controller.onRefresh(context),
          child: CustomScrollView(
            physics: const AlwaysScrollableScrollPhysics(
              parent: BouncingScrollPhysics(),
            ),
            slivers: [
              CategoryDetailsSliverAppBar(
                category: _controller.currentCategory,
                onBackTap: () => Navigator.of(context).pop(),
                onShareTap: () => _controller.onShareTapped(context),
              ),
              SliverToBoxAdapter(
                child: CategoryDetailsMetaSection(
                  category: _controller.currentCategory,
                  creationsCount: displayedProducts.length,
                ),
              ),
              if (subDepartments.isNotEmpty)
                SliverToBoxAdapter(
                  child: CategoryDetailsSubdepartmentsTabs(
                    subDepartments: subDepartments,
                    selectedIndex: _controller.selectedSubDepartmentIndex,
                    onTabSelected: (index) =>
                        _controller.onSubDepartmentSelected(
                      index,
                      () => setState(() {}),
                    ),
                  ),
                ),
              SliverToBoxAdapter(
                child: CategoryDetailsProductsHeader(
                  productsCount: displayedProducts.length,
                ),
              ),
              CategoryDetailsProductsGrid(
                displayedProducts: displayedProducts,
                wishlistIds: wishlistIds,
                isSubDepartmentFiltered:
                    _controller.selectedSubDepartmentIndex > 0,
                categoryName: _controller.currentCategory.name,
                onResetFilter: () => _controller.onSubDepartmentSelected(
                  0,
                  () => setState(() {}),
                ),
                onRetry: () => context.read<ProductCubit>().fetchProducts(
                      categoryId: _controller.currentCategory.id,
                    ),
                onToggleFavorite: (prod, isFav) =>
                    _controller.onToggleFavorite(
                  context,
                  product: prod,
                  isCurrentlyFav: isFav,
                ),
                onAddToCart: (prod) =>
                    _controller.onAddToCart(context, prod),
                onProductTapped: (prod) =>
                    _controller.onProductTapped(context, prod),
              ),
              const SliverToBoxAdapter(child: SizedBox(height: 40)),
            ],
          ),
        ),
      ),
    );
  }
}
