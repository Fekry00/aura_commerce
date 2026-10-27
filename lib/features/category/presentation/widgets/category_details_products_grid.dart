import 'package:aura/core/widgets/product_card.dart';
import 'package:aura/core/widgets/shimmer/app_shimmer.dart';
import 'package:aura/core/widgets/shimmer/home_shimmer_skeleton.dart';
import 'package:aura/features/category/presentation/widgets/category_details_empty_state.dart';
import 'package:aura/features/category/presentation/widgets/category_details_error_state.dart';
import 'package:aura/features/product/domain/entities/sub_entities/product_item_entity.dart';
import 'package:aura/features/product/presentation/cubit/product_cubit.dart';
import 'package:aura/features/product/presentation/cubit/product_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoryDetailsProductsGrid extends StatelessWidget {
  const CategoryDetailsProductsGrid({
    super.key,
    required this.displayedProducts,
    required this.wishlistIds,
    required this.isSubDepartmentFiltered,
    required this.categoryName,
    required this.onResetFilter,
    required this.onRetry,
    required this.onToggleFavorite,
    required this.onAddToCart,
    required this.onProductTapped,
  });

  final List<ProductItemEntity> displayedProducts;
  final Set<String> wishlistIds;
  final bool isSubDepartmentFiltered;
  final String categoryName;
  final VoidCallback onResetFilter;
  final VoidCallback onRetry;
  final void Function(ProductItemEntity product, bool isCurrentlyFav)
      onToggleFavorite;
  final ValueChanged<ProductItemEntity> onAddToCart;
  final ValueChanged<ProductItemEntity> onProductTapped;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductCubit, ProductState>(
      builder: (context, productState) {
        if (productState is ProductLoadingState) {
          return SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            sliver: SliverToBoxAdapter(
              child: AppShimmer(
                child: GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: 4,
                  gridDelegate:
                      const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.60,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                  ),
                  itemBuilder: (context, index) =>
                      const ProductCardShimmer(),
                ),
              ),
            ),
          );
        }

        if (productState is ProductErrorState) {
          return SliverToBoxAdapter(
            child: CategoryDetailsErrorState(
              message: productState.message,
              onRetry: onRetry,
            ),
          );
        }

        if (productState is ProductListEmptyState || displayedProducts.isEmpty) {
          return SliverToBoxAdapter(
            child: CategoryDetailsEmptyState(
              isSubDepartmentFiltered: isSubDepartmentFiltered,
              categoryName: categoryName,
              onResetFilter: onResetFilter,
            ),
          );
        }

        return SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          sliver: SliverGrid(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.65,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
            ),
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                final prod = displayedProducts[index];

                final badge = prod.discountPercent != null &&
                        prod.discountPercent! > 0
                    ? '-${prod.discountPercent!.toStringAsFixed(0)}%'
                    : (prod.isFeatured
                        ? 'FEATURED'
                        : (prod.isBestSeller ? 'BESTSELLER' : null));

                final bool isFav = wishlistIds.contains(prod.id.toString()) ||
                    prod.isFavorite;

                final img = (prod.thumbnailUrl != null &&
                        prod.thumbnailUrl!.isNotEmpty)
                    ? prod.thumbnailUrl!
                    : prod.imageUrl;

                return ProductCard(
                  title: prod.name,
                  price: '${prod.minPrice.toStringAsFixed(0)} EGP',
                  imageUrl: img,
                  rating: prod.rating,
                  reviewsCount: prod.reviewsCount,
                  badgeText: badge,
                  isFavorite: isFav,
                  onFavoriteTap: () => onToggleFavorite(prod, isFav),
                  onAddToCart: () => onAddToCart(prod),
                  onTap: () => onProductTapped(prod),
                );
              },
              childCount: displayedProducts.length,
            ),
          ),
        );
      },
    );
  }
}
