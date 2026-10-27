import 'package:aura/core/routing/routes.dart';
import 'package:aura/core/utils/functions/custom_snack_bar.dart';
import 'package:aura/features/cart/presentation/cubit/cart_cubit.dart';
import 'package:aura/features/category/domain/entities/category_entity.dart';
import 'package:aura/features/category/presentation/cubit/category_cubit.dart';
import 'package:aura/features/category/presentation/utils/category_ui_helper.dart';
import 'package:aura/features/product/domain/entities/sub_entities/product_item_entity.dart';
import 'package:aura/features/product/presentation/cubit/product_cubit.dart';
import 'package:aura/features/wishlist/presentation/cubit/wishlist_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoryDetailsController {
  CategoryDetailsController({
    required this.category,
    this.initialSubDepartment,
  }) : currentCategory = category;

  final CategoryEntity category;
  final String? initialSubDepartment;
  CategoryEntity currentCategory;
  int selectedSubDepartmentIndex = 0;

  void init(BuildContext context) {
    final subDepartments =
        CategoryUiHelper.getEffectiveSubDepartments(currentCategory);
    if (initialSubDepartment != null && subDepartments.isNotEmpty) {
      final index = subDepartments.indexWhere(
        (s) => s.name.toLowerCase() == initialSubDepartment!.toLowerCase(),
      );
      if (index != -1) {
        selectedSubDepartmentIndex = index + 1;
      }
    }

    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<CategoryCubit>().getCategoryDetails(currentCategory.id);
      context.read<ProductCubit>().fetchProducts(categoryId: currentCategory.id);
    });
  }

  void updateCategory(CategoryEntity updated) {
    currentCategory = updated;
  }

  void onSubDepartmentSelected(int index, VoidCallback onUpdate) {
    selectedSubDepartmentIndex = index;
    onUpdate();
  }

  Future<void> onRefresh(BuildContext context) async {
    await Future.wait([
      context.read<CategoryCubit>().getCategoryDetails(currentCategory.id),
      context.read<ProductCubit>().fetchProducts(categoryId: currentCategory.id),
    ]);
  }

  List<ProductItemEntity> getFilteredProducts({
    required List<ProductItemEntity> allProducts,
    required List<SubDepartmentEntity> subDepartments,
  }) {
    if (selectedSubDepartmentIndex == 0 || subDepartments.isEmpty) {
      return allProducts;
    }
    final subName =
        subDepartments[selectedSubDepartmentIndex - 1].name.toLowerCase();
    return allProducts.where((prod) {
      final text =
          '${prod.name.toLowerCase()} ${(prod.description ?? '').toLowerCase()}';
      return text.contains(subName);
    }).toList();
  }

  void onToggleFavorite(
    BuildContext context, {
    required ProductItemEntity product,
    required bool isCurrentlyFav,
  }) {
    context.read<WishlistCubit>().toggleWishlist(
          product.id,
          isCurrentlyFavorite: isCurrentlyFav,
        );
    showCustomSnackBar(
      context,
      message: isCurrentlyFav ? 'Removed from Wishlist' : 'Saved to Wishlist',
      type: SnackBarType.info,
    );
  }

  void onAddToCart(BuildContext context, ProductItemEntity product) {
    context.read<CartCubit>().addToCart(
          productId: product.id,
          quantity: 1,
        );
    showCustomSnackBar(
      context,
      message: 'Added ${product.name} to your Bag!',
      type: SnackBarType.info,
    );
  }

  void onProductTapped(BuildContext context, ProductItemEntity product) {
    Navigator.pushNamed(
      context,
      Routes.productDetailsView,
      arguments: product,
    );
  }

  void onShareTapped(BuildContext context) {
    showCustomSnackBar(
      context,
      message: 'Shared "${currentCategory.name}" link!',
      type: SnackBarType.info,
    );
  }

  void dispose() {}
}
