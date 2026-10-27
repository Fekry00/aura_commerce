import 'package:aura/core/di/injection_container.dart';
import 'package:aura/features/product/domain/entities/sub_entities/product_item_entity.dart';
import 'package:aura/features/product/presentation/controllers/product_details_controller.dart';
import 'package:aura/features/product/presentation/cubit/product_cubit.dart';
import 'package:aura/features/product/presentation/cubit/product_state.dart';
import 'package:aura/features/product/presentation/widgets/product_detail_app_bar.dart';
import 'package:aura/features/product/presentation/widgets/product_details_body.dart';
import 'package:aura/features/product/presentation/widgets/product_sticky_bottom_bar.dart';
import 'package:aura/features/wishlist/presentation/cubit/wishlist_cubit.dart';
import 'package:aura/features/wishlist/presentation/cubit/wishlist_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductDetailsView extends StatefulWidget {
  final ProductItemEntity product;

  const ProductDetailsView({
    super.key,
    required this.product,
  });

  @override
  State<ProductDetailsView> createState() => _ProductDetailsViewState();
}

class _ProductDetailsViewState extends State<ProductDetailsView> {
  late final ProductDetailsController _controller;

  @override
  void initState() {
    super.initState();
    _controller = ProductDetailsController();
  }

  @override
  Widget build(BuildContext context) {
    final intId = widget.product.id;

    return BlocProvider(
      create: (context) {
        final cubit = sl<ProductCubit>();
        if (intId > 0) {
          cubit.fetchProductDetails(intId.toString());
        }
        return cubit;
      },
      child: BlocBuilder<ProductCubit, ProductState>(
        builder: (context, state) {
          final details = (state is ProductSuccessState)
              ? state.productDetails
              : null;
          final liveProduct = details?.product;
          final rawPrice = (liveProduct != null && liveProduct.minPrice > 0)
              ? liveProduct.minPrice.toDouble()
              : (widget.product.minPrice > 0
                  ? widget.product.minPrice.toDouble()
                  : 1000.0);

          final wishlistState = context.watch<WishlistCubit>().state;
          final isFav = wishlistState is WishlistSuccessState &&
              wishlistState.wishlist.items.any(
                (i) => i.id == intId.toString(),
              );

          return Scaffold(
            backgroundColor: Colors.white,
            appBar: ProductDetailAppBar(
              isFavorite: isFav,
              onBackTap: () => Navigator.pop(context),
              onShareTap: () => _controller.onShareProduct(context),
              onFavoriteTap: () =>
                  _controller.onToggleWishlist(context, intId, isFav),
            ),
            bottomNavigationBar: ProductStickyBottomBar(
              quantity: _controller.quantity,
              formattedTotalPrice: _controller.formatTotalPrice(rawPrice),
              onIncrement: () =>
                  _controller.onIncrementQuantity(() => setState(() {})),
              onDecrement: () =>
                  _controller.onDecrementQuantity(() => setState(() {})),
              onAddToBag: () =>
                  _controller.onAddToBag(context, intId, rawPrice),
            ),
            body: ProductDetailsBody(
              product: widget.product,
              liveProduct: liveProduct,
              reviews: details?.reviews,
              controller: _controller,
              onStateUpdate: () => setState(() {}),
            ),
          );
        },
      ),
    );
  }
}