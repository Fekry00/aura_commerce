import 'package:aura/core/routing/main_tab_controller.dart';
import 'package:aura/core/routing/routes.dart';
import 'package:aura/core/utils/functions/custom_snack_bar.dart';
import 'package:aura/features/cart/presentation/cubit/cart_cubit.dart';
import 'package:aura/features/product/domain/entities/sub_entities/product_item_entity.dart';
import 'package:aura/features/wishlist/presentation/cubit/wishlist_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductDetailsController {
  int quantity = 1;
  int selectedColorIndex = 0;
  int selectedSizeIndex = 1;

  static const List<Color> colors = [
    Color(0xFF333333),
    Color(0xFFD6D6D6),
    Color(0xFFC5A07C),
  ];

  static const List<String> sizes = ['38mm', '40mm', '42mm'];

  void onIncrementQuantity(VoidCallback onUpdate) {
    quantity++;
    onUpdate();
  }

  void onDecrementQuantity(VoidCallback onUpdate) {
    if (quantity > 1) {
      quantity--;
      onUpdate();
    }
  }

  void onColorSelected(int index, VoidCallback onUpdate) {
    if (selectedColorIndex == index) return;
    selectedColorIndex = index;
    onUpdate();
  }

  void onSizeSelected(int index, VoidCallback onUpdate) {
    if (selectedSizeIndex == index) return;
    selectedSizeIndex = index;
    onUpdate();
  }

  void onSizingGuideTap(BuildContext context) {
    showCustomSnackBar(
      context,
      message: 'Opening Wrist Sizing Guide...',
      type: SnackBarType.info,
    );
  }

  void onAddToBag(BuildContext context, int productId, double basePrice) {
    try {
      context.read<CartCubit>().addToCart(
            productId: productId,
            quantity: quantity,
          );
    } catch (_) {}

    showCustomSnackBar(
      context,
      message: 'Added $quantity item(s) to Bag!',
      type: SnackBarType.success,
      actionLabel: 'View Bag',
      onAction: () {
        MainTabController.switchTab(2);
        Navigator.of(context).popUntil((route) => route.isFirst);
      },
    );
  }

  void onShareProduct(BuildContext context) {
    showCustomSnackBar(
      context,
      message: 'Share link copied!',
      type: SnackBarType.info,
    );
  }

  void onToggleWishlist(BuildContext context, int productId, bool isCurrentlyFav) {
    context.read<WishlistCubit>().toggleWishlist(
          productId,
          isCurrentlyFavorite: isCurrentlyFav,
        );
    showCustomSnackBar(
      context,
      message: isCurrentlyFav
          ? 'Removed from Wishlist'
          : 'Saved to Wishlist ❤️',
      type: isCurrentlyFav ? SnackBarType.info : SnackBarType.success,
    );
  }

  void onSeeAllReviews(BuildContext context, ProductItemEntity product) {
    Navigator.pushNamed(
      context,
      Routes.productReviewsView,
      arguments: product,
    );
  }

  String formatTotalPrice(double basePrice) {
    final num total = basePrice * quantity;
    return total.toStringAsFixed(2);
  }
}
