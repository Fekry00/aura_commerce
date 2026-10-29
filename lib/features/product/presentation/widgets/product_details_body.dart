import 'package:aura/core/routing/routes.dart';
import 'package:aura/core/theme/app_typography.dart';
import 'package:aura/core/utils/functions/custom_snack_bar.dart';
import 'package:aura/features/product/domain/entities/sub_entities/product_item_entity.dart';
import 'package:aura/features/product/domain/entities/sub_entities/product_review_entity.dart';
import 'package:aura/features/product/presentation/cubit/product_cubit.dart';
import 'package:aura/features/product/presentation/utils/product_ui_helper.dart';
import 'package:aura/features/product/presentation/widgets/product_details_info_section.dart';
import 'package:aura/features/product/presentation/widgets/product_image_section.dart';
import 'package:aura/features/product/presentation/widgets/product_specifications_card.dart';
import 'package:aura/features/product/presentation/widgets/product_variants_selector.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductDetailsBody extends StatelessWidget {
  final ProductItemEntity product;
  final ProductItemEntity? liveProduct;
  final List<ProductReviewEntity>? reviews;

  const ProductDetailsBody({
    super.key,
    required this.product,
    this.liveProduct,
    this.reviews,
  });

  @override
  Widget build(BuildContext context) {
    final title = liveProduct?.name.isNotEmpty == true
        ? liveProduct!.name
        : product.name;
    final rawPrice = (liveProduct != null && liveProduct!.minPrice > 0)
        ? liveProduct!.minPrice.toDouble()
        : product.minPrice.toDouble();
    final price = ProductUiHelper.formatPrice(rawPrice);
    final comparePrice = ProductUiHelper.formatComparePrice(
      liveProduct?.compareAtPrice ?? product.compareAtPrice,
    );
    final inStock = liveProduct?.inStock ?? product.inStock;
    final description = liveProduct?.description ??
        product.description ??
        'Authentic luxury product from our private catalogue.';
    final imageUrl = liveProduct?.imageUrl ?? product.imageUrl;
    final rating = liveProduct?.rating ?? product.rating;
    final reviewsCount = liveProduct?.reviewsCount ?? product.reviewsCount;
    final categoryName = liveProduct?.categoryName ?? product.categoryName;

    final productCubit = context.watch<ProductCubit>();
    final activeProduct = liveProduct ?? product;

    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ProductImageSection(
            imageUrl: imageUrl,
            rating: rating,
            reviews: reviewsCount,
            activeDot: productCubit.activeImageIndex,
            onDotSelected: productCubit.selectImage,
          ),
          Padding(
            padding: const EdgeInsets.all(AppSpacing.margin),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ProductDetailsInfoSection(
                  categoryName: categoryName,
                  title: title,
                  price: price,
                  comparePrice: comparePrice,
                  inStock: inStock,
                  description: description,
                ),
                const SizedBox(height: AppSpacing.spaceLg),
                const Divider(thickness: 0.5),
                const SizedBox(height: AppSpacing.spaceMd),
                ProductVariantsSelector(
                  selectedColorIndex: productCubit.selectedColorIndex,
                  selectedSizeIndex: productCubit.selectedSizeIndex,
                  product: activeProduct,
                  onColorSelected: productCubit.selectColor,
                  onSizeSelected: productCubit.selectSize,
                  onSizingGuideTap: () {
                    showCustomSnackBar(
                      context,
                      message: 'Opening Dimensions & Sizing Guide...',
                      type: SnackBarType.info,
                    );
                  },
                ),
                const SizedBox(height: AppSpacing.spaceLg),
                const Divider(thickness: 0.5),
                const SizedBox(height: AppSpacing.spaceMd),
                ProductSpecificationsCard(
                  reviews: reviews,
                  product: activeProduct,
                  onSeeAllReviewsTap: () {
                    Navigator.pushNamed(
                      context,
                      Routes.productReviewsView,
                      arguments: activeProduct,
                    );
                  },
                ),
                const SizedBox(height: AppSpacing.spaceXl),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
