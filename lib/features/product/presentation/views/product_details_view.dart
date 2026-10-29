import 'package:aura/core/routing/main_tab_controller.dart';
import 'package:aura/core/utils/functions/custom_snack_bar.dart';
import 'package:aura/features/product/domain/entities/sub_entities/product_item_entity.dart';
import 'package:aura/features/product/presentation/cubit/product_cubit.dart';
import 'package:aura/features/product/presentation/cubit/product_state.dart';
import 'package:aura/features/product/presentation/widgets/product_detail_app_bar.dart';
import 'package:aura/features/product/presentation/widgets/product_details_body.dart';
import 'package:aura/features/product/presentation/widgets/product_sticky_bottom_bar.dart';
import 'package:aura/features/wishlist/presentation/cubit/wishlist_cubit.dart';
import 'package:aura/features/wishlist/presentation/cubit/wishlist_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductDetailsView extends StatelessWidget {
  final ProductItemEntity product;

  const ProductDetailsView({super.key, required this.product});

  void _onCartSuccess(BuildContext context, String message) {
    showCustomSnackBar(
      context,
      message: message,
      type: SnackBarType.success,
      actionLabel: 'View Bag',
      onAction: () {
        MainTabController.switchTab(2);
        Navigator.of(context).popUntil((route) => route.isFirst);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final intId = product.id;

    return BlocConsumer<ProductCubit, ProductState>(
      listenWhen: (prev, curr) =>
          curr is AddToCartSuccessState || curr is AddToCartErrorState,
      listener: (context, state) {
        if (state is AddToCartSuccessState) {
          _onCartSuccess(context, state.message);
        } else if (state is AddToCartErrorState) {
          showCustomSnackBar(context, message: state.message, type: SnackBarType.error);
        }
      },
      buildWhen: (prev, curr) =>
          curr is! AddToCartSuccessState && curr is! AddToCartErrorState,
      builder: (context, state) {
        final details = (state is ProductSuccessState) ? state.productDetails : null;
        final liveProduct = details?.product;
        final rawPrice = (liveProduct != null && liveProduct.minPrice > 0)
            ? liveProduct.minPrice.toDouble()
            : (product.minPrice > 0 ? product.minPrice.toDouble() : 1000.0);

        final cubit = context.read<ProductCubit>();
        final quantity = (state is ProductSuccessState) ? state.quantity : cubit.quantity;
        final wishlistState = context.watch<WishlistCubit>().state;
        final isFav = wishlistState is WishlistSuccessState &&
            wishlistState.wishlist.items.any((i) => i.id == intId.toString());

        return Scaffold(
          backgroundColor: Colors.white,
          appBar: ProductDetailAppBar(
            isFavorite: isFav,
            onBackTap: () => Navigator.pop(context),
            onShareTap: () => showCustomSnackBar(
              context,
              message: 'Share link copied!',
              type: SnackBarType.info,
            ),
            onFavoriteTap: () => context
                .read<WishlistCubit>()
                .toggleWishlist(intId, isCurrentlyFavorite: isFav),
          ),
          bottomNavigationBar: ProductStickyBottomBar(
            quantity: quantity,
            formattedTotalPrice: cubit.formatTotalPrice(rawPrice),
            onIncrement: cubit.incrementQuantity,
            onDecrement: cubit.decrementQuantity,
            onAddToBag: () => cubit.addToCart(productId: intId),
          ),
          body: ProductDetailsBody(
            product: product,
            liveProduct: liveProduct,
            reviews: details?.reviews,
          ),
        );
      },
    );
  }
}