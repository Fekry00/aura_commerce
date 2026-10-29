import 'package:aura/core/routing/routes.dart';
import 'package:aura/core/theme/app_typography.dart';
import 'package:aura/core/utils/functions/custom_snack_bar.dart';
import 'package:aura/features/cart/presentation/cubit/cart_cubit.dart';
import 'package:aura/features/cart/presentation/cubit/cart_state.dart';
import 'package:aura/features/category/domain/entities/category_entity.dart';
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

class CategoryDetailsViewBody extends StatefulWidget {
  final CategoryEntity initialCategory;

  const CategoryDetailsViewBody({
    super.key,
    required this.initialCategory,
  });

  @override
  State<CategoryDetailsViewBody> createState() => _CategoryDetailsViewBodyState();
}

class _CategoryDetailsViewBodyState extends State<CategoryDetailsViewBody> {
  late CategoryEntity _currentCategory;

  @override
  void initState() {
    super.initState();
    _currentCategory = widget.initialCategory;
  }

  Future<void> _onRefresh() async {
    await Future.wait([
      context.read<CategoryCubit>().getCategoryDetails(_currentCategory.id),
      context.read<ProductCubit>().fetchProducts(categoryId: _currentCategory.id),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<CategoryCubit, CategoryState>(
          listener: (context, state) {
            if (state is GetCategoryDetailsSuccessState) {
              setState(() => _currentCategory = state.category);
            }
          },
        ),
        BlocListener<CartCubit, CartState>(
          listener: (context, state) {
            if (state is CartActionSuccessState) {
              showCustomSnackBar(context, message: state.message, type: SnackBarType.success);
            } else if (state is CartErrorState) {
              showCustomSnackBar(context, message: state.message, type: SnackBarType.error);
            }
          },
        ),
        BlocListener<WishlistCubit, WishlistState>(
          listener: (context, state) {
            if (state is WishlistItemAddedSuccessState) {
              showCustomSnackBar(context, message: state.message, type: SnackBarType.success);
            } else if (state is WishlistItemRemovedSuccessState) {
              showCustomSnackBar(context, message: state.message, type: SnackBarType.info);
            } else if (state is WishlistErrorState) {
              showCustomSnackBar(context, message: state.message, type: SnackBarType.error);
            }
          },
        ),
      ],
      child: BlocBuilder<CategoryCubit, CategoryState>(
        builder: (context, categoryState) {
          final cubit = context.read<CategoryCubit>();
          final subDepartments = CategoryUiHelper.getEffectiveSubDepartments(_currentCategory);
          final selectedSubIndex = cubit.selectedSubDepartmentIndex;
          final productState = context.watch<ProductCubit>().state;
          final wishlistState = context.watch<WishlistCubit>().state;
          final wishlistIds = wishlistState is WishlistSuccessState
              ? wishlistState.wishlist.items.map((i) => i.id).toSet()
              : <String>{};
          final allProducts = (productState is ProductListSuccessState)
              ? productState.products
              : const <ProductItemEntity>[];
          final displayedProducts = cubit.filterProducts(
            allProducts: allProducts,
            subDepartments: subDepartments,
            subDepartmentIndex: selectedSubIndex,
          );

          return RefreshIndicator(
            color: const Color(0xFF0B3B2C),
            onRefresh: _onRefresh,
            child: CustomScrollView(
              physics: const AlwaysScrollableScrollPhysics(
                parent: BouncingScrollPhysics(),
              ),
              slivers: [
                CategoryDetailsSliverAppBar(
                  category: _currentCategory,
                  onBackTap: () => Navigator.of(context).pop(),
                  onShareTap: () => showCustomSnackBar(
                    context,
                    message: 'Shared "${_currentCategory.name}" link!',
                    type: SnackBarType.info,
                  ),
                ),
                SliverToBoxAdapter(
                  child: CategoryDetailsMetaSection(
                    category: _currentCategory,
                    creationsCount: displayedProducts.length,
                  ),
                ),
                if (subDepartments.isNotEmpty)
                  SliverToBoxAdapter(
                    child: CategoryDetailsSubdepartmentsTabs(
                      subDepartments: subDepartments,
                      selectedIndex: selectedSubIndex,
                      onTabSelected: (i) => cubit.selectSubDepartment(i),
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
                  isSubDepartmentFiltered: selectedSubIndex > 0,
                  categoryName: _currentCategory.name,
                  onResetFilter: () => cubit.selectSubDepartment(0),
                  onRetry: () => context
                      .read<ProductCubit>()
                      .fetchProducts(categoryId: _currentCategory.id),
                  onToggleFavorite: (p, isFav) => context
                      .read<WishlistCubit>()
                      .toggleWishlist(p.id, isCurrentlyFavorite: isFav),
                  onAddToCart: (p) => context
                      .read<CartCubit>()
                      .addToCart(productId: p.id, quantity: 1),
                  onProductTapped: (p) => Navigator.pushNamed(
                    context,
                    Routes.productDetailsView,
                    arguments: p,
                  ),
                ),
                const SliverToBoxAdapter(
                  child: SizedBox(height: AppSpacing.spaceXl),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
