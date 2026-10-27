import 'package:aura/core/theme/app_typography.dart';
import 'package:aura/features/product/domain/entities/sub_entities/product_item_entity.dart';
import 'package:aura/features/product/domain/entities/sub_entities/product_review_entity.dart';
import 'package:aura/features/product/presentation/controllers/product_details_controller.dart';
import 'package:aura/features/product/presentation/utils/product_ui_helper.dart';
import 'package:aura/features/product/presentation/widgets/product_details_info_section.dart';
import 'package:aura/features/product/presentation/widgets/product_image_section.dart';
import 'package:aura/features/product/presentation/widgets/product_specifications_card.dart';
import 'package:aura/features/product/presentation/widgets/product_variants_selector.dart';
import 'package:flutter/material.dart';

class ProductDetailsBody extends StatelessWidget {
  final ProductItemEntity product;
  final ProductItemEntity? liveProduct;
  final List<ProductReviewEntity>? reviews;
  final ProductDetailsController controller;
  final VoidCallback onStateUpdate;

  const ProductDetailsBody({
    super.key,
    required this.product,
    this.liveProduct,
    this.reviews,
    required this.controller,
    required this.onStateUpdate,
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

    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ProductImageSection(
            imageUrl: imageUrl,
            rating: rating,
            reviews: reviewsCount,
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
                  selectedColorIndex: controller.selectedColorIndex,
                  selectedSizeIndex: controller.selectedSizeIndex,
                  colors: ProductDetailsController.colors,
                  sizes: ProductDetailsController.sizes,
                  onColorSelected: (index) =>
                      controller.onColorSelected(index, onStateUpdate),
                  onSizeSelected: (index) =>
                      controller.onSizeSelected(index, onStateUpdate),
                  onSizingGuideTap: () =>
                      controller.onSizingGuideTap(context),
                ),
                const SizedBox(height: AppSpacing.spaceLg),
                const Divider(thickness: 0.5),
                const SizedBox(height: AppSpacing.spaceMd),
                ProductSpecificationsCard(
                  reviews: reviews,
                  product: liveProduct ?? product,
                  onSeeAllReviewsTap: () =>
                      controller.onSeeAllReviews(context, liveProduct ?? product),
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
